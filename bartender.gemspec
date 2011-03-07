$LOAD_PATH.unshift 'lib'
require 'bartendere/version'

Gem::Specification.new do |spec|
  spec.authors = [ "Sebastian Arcila-Valenzuela" ]
  spec.date = Time.now.strftime('%Y-%m-%d')
  spec.description = "Ruby gem to handle releases in heroku."
  spec.email = "sebastianarcila@gmail.com"
  spec.has_rdoc = false
  spec.homepage = "http://github.com/sarcilav/bartende"
  spec.name = "bartender"
  spec.version = Bartender::VERSION
  spec.summary = %q{See example: https://github.com/sarcilav/bartender/blob/master/README.markdown}

  spec.files = %w( README.markdown Rakefile LICENSE )
  spec.files += Dir.glob("lib/**/*")

  spec.add_development_dependency "rspec"
  spec.add_dependency("git", ">= 1.2.5")
end