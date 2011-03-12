require 'sinatra/base'
require 'erb'
module Heroku
  module Bartender
    class Server < Sinatra::Base
      @@heroku_remote
      @@user
      @@pass
      dir = File.dirname(File.expand_path(__FILE__))
      set :views,  "#{dir}/views"
      get "/" do
        erb(:template, {}, :commits => Log.generate_commits, :current_version => Command.current_version(@@heroku_remote))
      end
      post "/" do
        if params[:sha]
          Command.move_to params[:sha], @@heroku_remote
        end
        erb(:template, {}, :commits => Log.generate_commits, :current_version => Command.current_version(@@heroku_remote))
      end
      def self.start(host, port, heroku_remote, user, pass)
        @@heroku_remote = heroku_remote
        authorize(user, pass)
        Heroku::Bartender::Server.run!(:host => host, :port => port)
      end

      def self.authorize(user, pass)
        if user != '' && pass != ''
          use Rack::Auth::Basic, "Restricted Area" do |username, password|
            [username, password] == [user, pass]
          end
        end
      end        
    end
  end
end
