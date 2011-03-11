require "spec_helper"

describe Heroku::Bartender::Command do
  
  describe "Methods" do
    it "should respond to move_to" do
      Heroku::Bartender::Command.respond_to?(:move_to).should be_true
    end
    describe "move_to" do
      before(:each) do
        @good_sha_commit =  Heroku::Bartender::Log.get_log.first.sha
        @good_remote = Grit::Repo.new('.').remote_list.last
      end
      context "remote and release exist" do
        it "should return true" do
          Heroku::Bartender::Command.move_to(@good_sha_commit, @good_remote).
            should be_true
        end
      end
      context "one of the params are wrong" do
        it "should return false" do
          Heroku::Bartender::Command.move_to(@good_sha_commit, "production123").
            should be_false
          Heroku::Bartender::Command.move_to("0", @good_remote).should be_false
          Heroku::Bartender::Command.move_to("0", "production123").should be_false
        end

      end
    end
  end
  it "should respond to exist sha" do
    Heroku::Bartender::Command.respond_to?(:sha_exist?).should be_true
  end
  describe "sha_exist?" do
    it "should return true with an existing commit" do
      Heroku::Bartender::Command.
        sha_exist?(Heroku::Bartender::Log.get_log.first.sha).should be_true
    end
    it "should return false with an unexisting commit" do
      Heroku::Bartender::Command.sha_exist?('0').should be_false
    end
  end
end
