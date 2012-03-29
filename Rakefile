require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

# There's undoubtedly a better way to run rspec from a rake task.
desc "Run all specs"
task :test do
  system "rspec test/*_test.rb"
  exit $?.exitstatus
end
