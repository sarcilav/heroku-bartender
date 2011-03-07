require 'rspec/core/rake_task'

file_list = FileList['spec/*_spec.rb']

RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = file_list
  t.rspec_opts = ["--colour", "--format progress", "-p"]
end

desc 'Default: run specs.'
task :default => 'spec'
