module Bartender
  class Command
    # move to an specific commit
    # Pending ada more testing stuff
    def self.move_to release
      `git push -f heroku #{release}:master`
    end
  end  
end
