require File.dirname(__FILE__) + '/spec_helper'

describe "Nerb (module)" do
  
  it "should have proper specs"
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { |r| r.add_slice(:Nerb) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should be registered in Merb::Slices.slices" do
    Merb::Slices.slices.should include(Nerb)
  end
  
  it "should be registered in Merb::Slices.paths" do
    Merb::Slices.paths[Nerb.name].should == current_slice_root
  end
  
  it "should have an :identifier property" do
    Nerb.identifier.should == "nerb"
  end
  
  it "should have an :identifier_sym property" do
    Nerb.identifier_sym.should == :nerb
  end
  
  it "should have a :root property" do
    Nerb.root.should == Merb::Slices.paths[Nerb.name]
    Nerb.root_path('app').should == current_slice_root / 'app'
  end
  
  it "should have a :file property" do
    Nerb.file.should == current_slice_root / 'lib' / 'nerb.rb'
  end
  
  it "should have metadata properties" do
    Nerb.description.should == "Nerb is a Pocket CMS Slice"
    Nerb.version.should == "0.0.1"
    Nerb.author.should == "Lance Carlson"
  end
  
  # it "should have :routes and :named_routes properties" do
    # Nerb.routes.should_not be_empty
    # Nerb.named_routes[:nerb_index].should be_kind_of(Merb::Router::Route)
  # end

  # it "should have an url helper method for slice-specific routes" do
  #   Nerb.url(:controller => 'main', :action => 'show', :format => 'html').should == "/nerb/main/show.html"
  #   Nerb.url(:nerb_index, :format => 'html').should == "/nerb/index.html"
  # end
  
  it "should have a config property (Hash)" do
    Nerb.config.should be_kind_of(Hash)
  end
  
  it "should have bracket accessors as shortcuts to the config" do
    Nerb[:foo] = 'bar'
    Nerb[:foo].should == 'bar'
    Nerb[:foo].should == Nerb.config[:foo]
  end
  
  it "should have a :layout config option set" do
    Nerb.config[:layout].should == :nerb
  end
  
  it "should have a dir_for method" do
    app_path = Nerb.dir_for(:application)
    app_path.should == current_slice_root / 'app'
    [:view, :model, :controller, :helper, :mailer, :part].each do |type|
      Nerb.dir_for(type).should == app_path / "#{type}s"
    end
    public_path = Nerb.dir_for(:public)
    public_path.should == current_slice_root / 'public'
    [:stylesheet, :javascript, :image].each do |type|
      Nerb.dir_for(type).should == public_path / "#{type}s"
    end
  end
  
  it "should have a app_dir_for method" do
    root_path = Nerb.app_dir_for(:root)
    root_path.should == Merb.root / 'slices' / 'nerb'
    app_path = Nerb.app_dir_for(:application)
    app_path.should == root_path / 'app'
    [:view, :model, :controller, :helper, :mailer, :part].each do |type|
      Nerb.app_dir_for(type).should == app_path / "#{type}s"
    end
    public_path = Nerb.app_dir_for(:public)
    public_path.should == Merb.dir_for(:public) / 'slices' / 'nerb'
    [:stylesheet, :javascript, :image].each do |type|
      Nerb.app_dir_for(type).should == public_path / "#{type}s"
    end
  end
  
  it "should have a public_dir_for method" do
    public_path = Nerb.public_dir_for(:public)
    public_path.should == '/slices' / 'nerb'
    [:stylesheet, :javascript, :image].each do |type|
      Nerb.public_dir_for(type).should == public_path / "#{type}s"
    end
  end
  
  it "should have a public_path_for method" do
    public_path = Nerb.public_dir_for(:public)
    Nerb.public_path_for("path", "to", "file").should == public_path / "path" / "to" / "file"
    [:stylesheet, :javascript, :image].each do |type|
      Nerb.public_path_for(type, "path", "to", "file").should == public_path / "#{type}s" / "path" / "to" / "file"
    end
  end
  
  it "should have a app_path_for method" do
    Nerb.app_path_for("path", "to", "file").should == Nerb.app_dir_for(:root) / "path" / "to" / "file"
    Nerb.app_path_for(:controller, "path", "to", "file").should == Nerb.app_dir_for(:controller) / "path" / "to" / "file"
  end
  
  it "should have a slice_path_for method" do
    Nerb.slice_path_for("path", "to", "file").should == Nerb.dir_for(:root) / "path" / "to" / "file"
    Nerb.slice_path_for(:controller, "path", "to", "file").should == Nerb.dir_for(:controller) / "path" / "to" / "file"
  end
  
  it "should keep a list of path component types to use when copying files" do
    (Nerb.mirrored_components & Nerb.slice_paths.keys).length.should == Nerb.mirrored_components.length
  end
  
end