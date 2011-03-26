require 'sinatra/base'
require 'erb'

module Heroku
  module Bartender
    class Server < Sinatra::Base

      configure do
        dir = File.dirname(File.expand_path(__FILE__))
        set :views, "#{dir}/views"
        set :public, "#{dir}/views"
        set :deployed_versions, { }
        set :remote, nil
      end

      before do
        @commits = Log.generate_commits
        @current_version = Command.current_version(remote)
        @current_state = html_status
      end

      get "/" do
        erb :template
      end

      post "/" do
        if params[:sha]
          Server.update_build_status(Command.move_to(params[:sha], remote))
          deployed_versions[params[:sha]] = [Time.now, html_status]
        end
        erb(:template)
      end

      def self.start(host, port, heroku_remote, username, pass)
        set :remote, heroku_remote
        update_build_status(nil)
        authorize(username, pass)
        Heroku::Bartender::Server.run!(:host => host, :port => port)
      end

      def self.authorize(user, pass)
        if user != '' && pass != ''
          use Rack::Auth::Basic, "Restricted Area" do |usr, pwd|
            [usr, pwd] == [user, pass]
          end
        end
      end

      # encapsulate this behavior here so it's easier to get rid
      # of the class variable in the future.
      def self.update_build_status(value)
        @@status = value
      end

      helpers do
        include Rack::Utils

        def deployed_versions
          settings.deployed_versions
        end

        def status
          @@status
        end

        def remote
          settings.remote
        end

        def current_class(current_version_sha, sha)
          sha == current_version_sha ? 'current' : ''
        end

        def html_status(state=status)
          case state
          when true
            return "ok"
          when false
            return "fail"
          else
            return "unknown"
          end
        end

        def color_status(version_sha)
          deployed_versions[version_sha].last if deployed_versions[version_sha]
        end
      end
    end
  end
end
