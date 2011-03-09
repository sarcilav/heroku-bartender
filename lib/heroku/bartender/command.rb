module Heroku
  module Bartender
    class Command
      # move to an specific commit
      # Pending ada more testing stuff
      def move_to release, heroku_remote
        `git push -f #{heroku_remote} #{release}:master`
      end
    end
  end
end
