module Bartender
  class Command
    def self.move_to release
      `git push -f heroku #{release}:master`
    end
  end  
end
