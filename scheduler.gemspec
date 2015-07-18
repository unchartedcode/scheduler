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

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "mock_redis"
  spec.add_development_dependency "byebug"

  spec.add_dependency "rails"
  spec.add_dependency "redis"
  spec.add_dependency "sidekiq"
end
