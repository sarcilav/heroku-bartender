require "spec_helper"

describe Bartender::Log do
  METHODS = [:get_log, :generate_commits]
  describe "methods" do
    METHODS.each do |method|
      it "should respond to #{method}" do
        Bartender::Log.respond_to?(method).should be_true
      end
    end
  end
  describe "generate commits" do
    before(:each) do
      @commits = Bartender::Log.generate_commits
    end
    it "should return an array of commits" do
      @commits.class.should eq(Array)
      @commits.first.class.should eq(Bartender::Commit)
    end
  end
  describe "get log" do
    before(:each) do
      @git_log = Bartender::Log.get_log
    end
    it "should return Git::Log" do
      @git_log.class.should eq(Git::Log)
    end
    COLLECTION_METHODS = [:each, :map, :first]
    COLLECTION_METHODS.each do |cmethod|
      it "should support #{cmethod}" do
        @git_log.respond_to?(cmethod).should be_true
      end
    end
    context "an element of get log" do
      COMMIT_METHODS = [:sha, :author, :date, :message]
      COMMIT_METHODS.each do |cmtmethod|
        it "should support #{cmtmethod}" do
          @git_log.first.respond_to?(cmtmethod).should be_true
        end
      end
      AUTHOR_METHODS = [:name, :email]
      AUTHOR_METHODS.each do |amethod|
        it "should support #{amethod}" do
          @git_log.first.author.respond_to?(amethod).should be_true
        end
      end
    end
  end
end
