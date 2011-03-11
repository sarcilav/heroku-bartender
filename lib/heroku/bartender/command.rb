require 'grit'
module Heroku
  module Bartender
    class Command
      def self.sha_exist?(sha)
        unless `git show #{sha}`.empty?
          return true
        end
        false
      end
      # move to an specific commit
      def self.move_to release, heroku_remote
        repo = Grit::Repo.new('.') 
        if repo.remote_list.include? heroku_remote and sha_exist? release
          `git push -f #{heroku_remote} #{release}:master`
          return true
        end
        false
      end
    end
  end
end
