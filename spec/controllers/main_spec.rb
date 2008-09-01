require File.dirname(__FILE__) + '/../spec_helper'

describe "Nerb::Main (controller)" do
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { |r| r.add_slice(:Nerb) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should have access to the slice module" do
    controller = dispatch_to(Nerb::Main, :index)
    controller.slice.should == Nerb
    controller.slice.should == Nerb::Main.slice
  end
  
  it "should have an index action" do
    controller = dispatch_to(Nerb::Main, :index)
    controller.status.should == 200
    controller.body.should contain('Nerb')
  end
  
  it "should work with the default route" do
    controller = get("/nerb/main/index")
    controller.should be_kind_of(Nerb::Main)
    controller.action_name.should == 'index'
  end
  
  it "should work with the example named route" do
    controller = get("/nerb/index.html")
    controller.should be_kind_of(Nerb::Main)
    controller.action_name.should == 'index'
  end
  
  it "should have routes in Nerb.routes" do
    Nerb.routes.should_not be_empty
  end
  
  it "should have a slice_url helper method for slice-specific routes" do
    controller = dispatch_to(Nerb::Main, 'index')
    controller.slice_url(:action => 'show', :format => 'html').should == "/nerb/main/show.html"
    controller.slice_url(:nerb_index, :format => 'html').should == "/nerb/index.html"
  end
  
  it "should have helper methods for dealing with public paths" do
    controller = dispatch_to(Nerb::Main, :index)
    controller.public_path_for(:image).should == "/slices/nerb/images"
    controller.public_path_for(:javascript).should == "/slices/nerb/javascripts"
    controller.public_path_for(:stylesheet).should == "/slices/nerb/stylesheets"
  end
  
  it "should have a slice-specific _template_root" do
    Nerb::Main._template_root.should == Nerb.dir_for(:view)
    Nerb::Main._template_root.should == Nerb::Application._template_root
  end

end