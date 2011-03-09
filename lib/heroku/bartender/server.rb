require 'sinatra/base'
require 'erb'
module Heroku
  module Bartender
    class Server < Sinatra::Base
      @@heroku_remote
      dir = File.dirname(File.expand_path(__FILE__))
      set :views,  "#{dir}/views"
      get "/" do
        erb(:template, {}, :commits => Log.generate_commits)
      end
      post "/" do
        if params[:sha]
          Command.move_to params[:sha], @@heroku_remote
        end
        erb(:template, {}, :commits => Log.generate_commits)
      end
      def self.start(host, port, heroku_remote)
        @@heroku_remote = heroku_remote
        puts @@heroku_remote
        Heroku::Bartender::Server.run!(:host => host, :port => port)
      end
    end
  end
end
