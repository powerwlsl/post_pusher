lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'post_pusher/version'

Gem::Specification.new do |spec|
  spec.authors = ['PatientsLikeMe']
  spec.description = 'A tool to run a set of tasks after deploys'
  spec.email = ['engineers@patientslikeme.com']
  spec.homepage = 'https://www.patientslikeme.com'
  spec.name = 'post_pusher'
  spec.license = 'MIT'
  spec.summary = 'A tool to run a set of tasks after deploys'
  spec.version = PostPusher::VERSION

  spec.files = Dir["{bin,lib,db}/**/*", "README.md", "Rakefile"]
  spec.bindir = 'exe'
  spec.executables = ["post_push"]
  spec.test_files = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails" # TODO: get tests running without this.

  spec.add_development_dependency "sqlite3", "~> 1.3.6"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters", "~> 1.1.11"
  spec.add_development_dependency "minitest-spec-rails"
  spec.add_development_dependency "pry"
end
