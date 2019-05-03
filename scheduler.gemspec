# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scheduler/version'

Gem::Specification.new do |spec|
  spec.name          = "uncharted-scheduler"
  spec.version       = Scheduler::VERSION
  spec.authors       = ["Sam Saffron", "Nathan Palmer"]
  spec.email         = ["nathan@nathanpalmer.com"]

  spec.summary       = %q{Performance friendly recurring jobs for Sidekiq}
  spec.description   = %q{Allows you to define recurring workers for Sidekiq without requiring a dedicated job server}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17.3"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "coveralls"

  spec.add_dependency "rails", ">= 4.2", "< 6.0"
  spec.add_dependency "redis"
  spec.add_dependency "sidekiq"
  spec.add_dependency "redlock", "~> 1.0.0"
end
