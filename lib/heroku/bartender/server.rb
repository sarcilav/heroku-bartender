require 'sinatra/base'
require 'erb'
module Heroku
  module Bartender
    class Server < Sinatra::Base
      @@options = {}
      
      configure do
        dir = File.dirname(File.expand_path(__FILE__))
        set :views,  "#{dir}/views"
        set :public, "#{dir}/public"
        set :deployed_versions, {}
      end

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
      
      before do
        @page    = params[:page] || 0
        @commits = Log.generate_commits(params.merge({:max_per_page => Server.max_per_page}))
      end
     
      get "/" do
        erb :template
      end
      
      post "/" do
        if params[:sha]
          begin
            Command.move_to params[:sha], predeploy, target
            deployed_versions[params[:sha]] = [Time.now, true, nil]
          rescue Exception => e
            deployed_versions[params[:sha]] = [Time.now, false, e]
          end
        end
        erb :template
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

        def deployed_versions
          settings.deployed_versions
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
          if deployed_versions[version_sha]
            status = deployed_versions[version_sha][1]
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
