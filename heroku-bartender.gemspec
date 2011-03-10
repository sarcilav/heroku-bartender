$LOAD_PATH.unshift 'lib'
require 'heroku/bartender/version'

Gem::Specification.new do |spec|
  spec.authors                      = [ "Sebastian Arcila-Valenzuela" ]
  spec.date                         = Time.now.strftime('%Y-%m-%d')
  spec.description                  = "Ruby gem to handle releases in heroku."
  spec.email                        = "sebastianarcila@gmail.com"
  spec.has_rdoc                     = false
  spec.homepage                     = "http://github.com/sarcilav/heroku-bartender"
  spec.name                         = "heroku-bartender"
  spec.version                      = Heroku::Bartender::VERSION
  spec.summary                      = %q{See example: https://github.com/sarcilav/heroku-bartender/blob/master/README.markdown}

  spec.files                        = %w( README.markdown Rakefile LICENSE )
  spec.files                       += Dir.glob("lib/**/*")
  spec.files                       += Dir.glob("bin/**/*")
  
  spec.add_development_dependency "rspec"
  spec.add_dependency("git", ">= 1.2.5")
  spec.add_dependency("sinatra", ">= 1.2.0")
  spec.add_dependency("choice", ">= 0.1.4")

  spec.executables                     = %w( heroku-bartender )
end
