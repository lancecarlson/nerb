require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Link do
  before do
    @link = Link.new
  end
  
  describe "Link.locate" do
    before do
      @link = Link.create! :path => "test-path", :page_id => 1
    end
    
    it "should find the path from the request" do      
      Link.locate("/test-path").should == @link
    end
  end
  
  describe "valid link" do
    it "should only allow the following characters in the path: A-Za-z0-9./-_" do
      # @link.page_id = 1
      # @link.path = "@!()asdksad"
      # @link.valid?.should be_false
      # @link.path = "valid-path"
      # @link.valid?.should be_true
      pending("validates_format b0rked?")
    end
  end
  
  describe "path=" do
    
    it "should remove all whitespace" do
      @link.path = "   there-is-space- here    "
      @link.path.should == "there-is-space-here"
    end
    
    it "should remove the leading slash if one is included" do
      @link.path = "/there-is-a-leading-slash"
      @link.path.should == "there-is-a-leading-slash"
    end
  end

end