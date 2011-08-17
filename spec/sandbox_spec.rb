require "spec_helper"

describe "Heroku::Bartender::Sandbox" do
  before(:each) do
    @sha = `git rev-parse HEAD`
    @sha_to_go = `git rev-parse HEAD~1`
    @s = Heroku::Bartender::Sandbox.new(@sha_to_go.strip)
  end
  describe "creation of sandbox directory" do
    it "should create a directory in the temp dir" do
      @s.predeploy("echo hello")
      File.directory?(@s.sandbox_dir).should be_true
    end
  end

  describe "move to a specific version" do
    it "should checkout the given sha" do
      @s.predeploy("echo hello")
      @sha.should_not == @sha_to_go
      Dir.chdir(@s.sandbox_dir) do
        `git rev-parse HEAD`.should == @sha_to_go
      end
    end
  end
  
end
