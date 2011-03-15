require 'sinatra/base'
require 'erb'
module Heroku
  module Bartender
    class Server < Sinatra::Base
      @@heroku_remote
      @@user
      @@pass
      @@deployed_versions = {}
      @@status = nil
      dir = File.dirname(File.expand_path(__FILE__))
      set :views,  "#{dir}/views"
      get "/" do
        erb(:template, {}, :commits => Log.generate_commits,
            :current_version => Command.current_version(@@heroku_remote),
            :deployed_versions => @@deployed_versions)
      end
      post "/" do
        if params[:sha]
          @@status = Command.move_to params[:sha], @@heroku_remote
          @@deployed_versions[params[:sha]] = [Time.now, @@status]
        end
        erb(:template, {}, :commits => Log.generate_commits,
            :current_version => Command.current_version(@@heroku_remote),
            :deployed_versions => @@deployed_versions)
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

      helpers do
        include Rack::Utils
        def current_class(current_version_sha, sha)
          sha == current_version_sha ? 'current' : ''
        end

        def color_status(version_sha)
          if @@deployed_versions[version_sha]
            status = @@deployed_versions[version_sha][1]
            if status == true
              return 'green'
            elsif status == false
              return 'red'
            end
            return 'yellow'
          end
          ''
        end
        def state(status)
          if status == true
            return 'OK'
          elsif status == false
            return 'FAIL'
          end
          'UNKNOWN'
        end
      end
    end
  end
end
