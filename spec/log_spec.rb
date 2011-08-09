require "spec_helper"

describe Heroku::Bartender::Log do
  METHODS = [:get_log, :generate_commits]
  describe "methods" do
    METHODS.each do |method|
      it "should respond to #{method}" do
        Heroku::Bartender::Log.respond_to?(method).should be_true
      end
    end
  end
  describe "generate commits" do
    before(:each) do
      @commits = Heroku::Bartender::Log.generate_commits
    end
    it "should return an array of commits" do
      @commits.class.should eq(Array)
      @commits.first.class.should eq(Grit::Commit)
    end
  end
  describe "get log" do
    before(:each) do
      @git_log = Heroku::Bartender::Log.get_log
    end
    it "should return an array of commits" do
      @git_log.class.should eq(Array)
      @git_log.first.class.should eq(Grit::Commit)
    end
    COLLECTION_METHODS = [:each, :map, :first]
    COLLECTION_METHODS.each do |cmethod|
      it "should support #{cmethod}" do
        @git_log.respond_to?(cmethod).should be_true
      end
    end
    describe "generate paginated commits" do
      it "should return to different arrays with the same size" do
        commits1 = Heroku::Bartender::Log.get_log({:page => 0, :max_per_page => 10})
        commits2 = Heroku::Bartender::Log.get_log({:page => 1, :max_per_page => 10})
        commits1.size.should == 10
        commits2.size.should == 10
        ids1 = commits1.map(&:id)
        ids2 = commits2.map(&:id)
        ids1.each do |id|
          ids2.should_not include id
        end
        ids2.each do |id|
          ids1.should_not include id
        end
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
