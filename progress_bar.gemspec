# frozen_string_literal: true

require_relative "lib/progress_bar/version"

Gem::Specification.new do |s|
  s.name        = "progress_bar"
  s.version     = ProgressBar::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Sadauskas"]
  s.email       = ["psadauskas@gmail.com"]
  s.homepage    = "http://github.com/paul/progress_bar"
  s.license     = "WTFPL"
  s.summary     = "Simple Progress Bar for output to a terminal"
  s.description = "Give people feedback about long-running tasks without overloading them with information: Use a progress bar, like Curl or Wget!"

  s.required_ruby_version = ">= 2.4.0"

  s.add_dependency("highline", ">= 1.6")
  s.add_dependency("options", "~> 2.3.0")

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.metadata["rubygems_mfa_required"] = "true"
end
