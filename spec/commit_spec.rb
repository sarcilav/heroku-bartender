require 'spec_helper'

describe Bartender::Commit do
  before(:each) do
    @commit = Bartender::Commit.new
  end
  ATTR = [ :sha, :author, :email, :message, :date]
  describe "attributes" do
    ATTR.each do |attr|
      it "should respond to #{attr}" do
        @commit.respond_to?(attr).should be_true
      end
    end
  end
end
