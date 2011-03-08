require "spec_helper"

describe Heroku::Bartender::Command do
  describe "Methods" do
    it "should respond_to move_to" do
      Heroku::Bartender::Command.respond_to?(:move_to).should be_true
    end
    describe "move_to" do
      it "need to be tested"
    end
  end
end
