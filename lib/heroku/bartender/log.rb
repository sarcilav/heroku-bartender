require "grit"
module Heroku
  module Bartender
    class Log
      class << self
        def get_log(options = {})
          options[:page] ||= 0
          offset = options[:max_per_page].to_i * options[:page].to_i
          Grit::Repo.new('.').commits('master',
                                      options[:max_per_page],
                                      offset
                                      )
        end
        alias :generate_commits :get_log
      end
    end
  end
end
