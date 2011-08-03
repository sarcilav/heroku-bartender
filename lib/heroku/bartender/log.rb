require "grit"
module Heroku
  module Bartender
    class Log
      def self.get_log(options = {})
        options[:page] ||= 0
        offset = options[:max_per_page].to_i * options[:page].to_i
        Grit::Repo.new('.').commits('master',
                                    options[:max_per_page],
                                    offset
                                    )
      end
      def self.generate_commits(options = {})
        get_log(options).map do |item|
          Commit.new({ :sha   => item.sha,
                       :author  => item.author.name,
                       :email => item.author.email,
                       :message => item.message,
                       :date  => item.date
                     })
        end
      end
    end
  end
end
