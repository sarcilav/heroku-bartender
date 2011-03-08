require 'sinatra/base'
require 'erb'

module Bartender
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))
    set :views,  "#{dir}/views"

    get "/" do
      erb(:template, {}, :commits => Log.generate_commits)
    end
    post "/" do
      if params[:sha]
        Command.move_to params[:sha]
      end
      erb(:template, {}, :commits => Log.generate_commits)
    end
  end
end
