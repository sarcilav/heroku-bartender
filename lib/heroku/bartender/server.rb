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
      
      def self.max_per_page
        @@options[:commits_per_page]
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
      
      def self.config
        Config.send("remote.#{Server.target}")
      end

      def self.predeploy
        config.predeploy.to_s
      end
  
      get "/" do
        page = params[:page] || 0
        erb(:template, {}, :commits => Log.generate_commits(params.merge({:max_per_page => Server.max_per_page})),
            :current_version => Command.current_version(Server.target),
            :deployed_versions => @@deployed_versions,
            :status => @@status,
            :page => page
            )
      end
      
      post "/" do
        page = params[:page] || 0
        if params[:sha]
          begin
            Command.move_to params[:sha], predeploy, target
            @@status = true
            @@deployed_versions[params[:sha]] = [Time.now, @@status, nil]
          rescue Exception => e
            @@status = false
            @@deployed_versions[params[:sha]] = [Time.now, @@status, e]
          end
        end
        erb(:template, {}, :commits => Log.generate_commits(params.merge({:max_per_page => 20})),
            :current_version => Command.current_version(Server.target),
            :deployed_versions => @@deployed_versions,
            :status => @@status,
            :page => page
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
        
        def pagination(page)
          page = page.to_i
          if page == 0
            '<a href="/?page=1"> Next </a>'
          elsif page > 0
            "<a href='/?page=0'> First </a> |
             <a href='/?page=#{page - 1}'> Prev </a> |
             <a href='/?page=#{page + 1}'> Next </a>"
          end
        end
        
        def build_status(version_sha)
          if @@deployed_versions[version_sha]
            status = @@deployed_versions[version_sha][1]
            if status == true
              return 'ok'
            elsif status == false
              return 'fail'
            end
            return 'unknown'
          end
          ''
        end

        def user_img_url(email)
          "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}.jpg?"
        end
        
        def target
          Server.target
        end
        
        def predeploy
          Server.predeploy
        end
        
      end
    end
  end
end
