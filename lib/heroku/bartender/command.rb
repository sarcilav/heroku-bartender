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
      
      def self.move_to release, predeploy, heroku_remote
        @@last_error = nil
        if predeploy && ! predeploy.strip.empty?
          Sandbox.new(release).predeploy(predeploy.strip)
        end          
        repo = Grit::Repo.new('.')
        if ! repo.remote_list.include?(heroku_remote)
          raise "No such remote `#{heroku_remote}`"
        end
        if ! sha_exist?(release)
          raise "No such commit `#{release}"
        end
        rc = system("git push -f #{heroku_remote} #{release}:master")
        if rc.nil? || ! rc 
          raise "Error in `git push -f #{heroku_remote} #{release}:master`: #{$?}"
        end
      end
    end
  end
end
