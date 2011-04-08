require "grit"
module Heroku
  module Bartender
    class Log
      def self.get_log(options = {})
        Grit::Repo.new('.').log('master', nil, options)
      end
      def self.generate_commits(options = {})
        get_log(options).map do |item|
          Commit.new({ :sha   => item.sha         , :author  => item.author.name,
                       :email => item.author.email, :message => item.message,
                       :date  => item.date
                     })
        end
      end
    end
  end
end
