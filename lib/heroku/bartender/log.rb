require "grit"
module Heroku
  module Bartender
    class Log
      def self.get_log(count)
        Grit::Repo.new('.').log('master', nil, { :max_count => count })
      end
      def self.generate_commits(count)
        get_log(count).map do |item|
          Commit.new({ :sha   => item.sha         , :author  => item.author.name,
                       :email => item.author.email, :message => item.message,
                       :date  => item.date
                     })
        end
      end
    end
  end
end
