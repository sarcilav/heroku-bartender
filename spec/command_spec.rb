require "spec_helper"

describe Bartender::Command do
  describe "Methods" do
    it "should respond_to move_to" do
      Bartender::Command.respond_to?(:move_to).should be_true
    end
  end
end
