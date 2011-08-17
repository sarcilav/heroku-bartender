require 'tmpdir'
require 'fileutils'
module Heroku
  module Bartender
    class Sandbox

      attr_accessor :sha, :name, :current_dir, :sandbox_dir

      def initialize(sha)
        @sha         = sha
        @name        = gen_sandbox_name
        @sandbox_dir = "#{Dir.tmpdir}/#{@name}/"
        @current_dir = "#{Dir.pwd}/"
      end

      def predeploy(command)
        copy_current_repo_to_me
        Dir.chdir(@sandbox_dir) do
          `git checkout #{@sha}`
          rc = system(command)
          if rc.nil? || ! rc
            raise "Error executing pre-deploy command '#{command}': #{$?}"
          end
        end
      end

      private
      def random
        rand(Time.now.to_i)
      end

      def gen_sandbox_name
        "bartender-sandbox-#{random}-#{@sha[0..7]}"
      end

      def copy_current_repo_to_me
        FileUtils.cp_r @current_dir, @sandbox_dir
      end

    end
  end
end
