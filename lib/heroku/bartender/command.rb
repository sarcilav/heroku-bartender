require 'grit'
module Heroku
  module Bartender
    class Command

      def self.current_version(heroku_remote)
        repo = Grit::Repo.new('.') 
        if repo.remote_list.include?(heroku_remote)
          return `git ls-remote #{heroku_remote}`.split("\t").first
        end
        nil
      end
      def self.sha_exist?(sha)
        if sha and not `git show #{sha}`.empty? 
          return true
        end
        false
      end
      # move to an specific commit
      def self.move_to release, heroku_remote
        repo = Grit::Repo.new('.') 
        if repo.remote_list.include?(heroku_remote) && sha_exist?(release)
          `git push -f #{heroku_remote} #{release}:master`
          return true
        end
        false
      end
    end
  end
end
