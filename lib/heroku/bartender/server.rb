require 'sinatra/base'
require 'erb'
module Heroku
  module Bartender
    class Server < Sinatra::Base

      @@deployed_versions = {}
      @@status = nil
      @@options = {}

      dir = File.dirname(File.expand_path(__FILE__))
      set :views,  "#{dir}/views"
      set :public, "#{dir}/public"

      def self.commits
        @@options[:commits]
      end

      def self.user
        @@options[:user]
      end

      def self.password
	      @@options[:password]
      end

      def self.target
        @@options[:target] || 'heroku'
      end
      
      def self.host
        @@options[:host]
      end
      
      def self.port
        @@options[:port]
      end  

      def self.log_options
        options = { }
        options.merge({ :max_count => Server.commits }) if (Server.commits > 0)
        options
      end

      get "/" do
        erb(:template, {}, :commits => Log.generate_commits(Server.log_options),
            :current_version => Command.current_version(Server.target),
            :deployed_versions => @@deployed_versions,
            :status => @@status
            )
      end
      
      post "/" do
        if params[:sha]
          @@status = Command.move_to params[:sha], target
          @@deployed_versions[params[:sha]] = [Time.now, @@status]
        end
        erb(:template, {}, :commits => Log.generate_commits(Server.log_options),
            :current_version => Command.current_version(Server.target),
            :deployed_versions => @@deployed_versions,
            :status => @@status
            )
      end
            
      def self.start(options = {})
        @@options = options
        authorize(user, password)
        run!(:host => host, :port => port)
      end

      def self.authorize(user, password)
        if ! user.nil?
          use Rack::Auth::Basic, "Restricted Area" do |u, p|
            [u, p] == [user, password]
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
        
        def target
          Server.target
        end
        
      end
    end
  end
end
