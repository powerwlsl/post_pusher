lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'post_pusher/version'

Gem::Specification.new do |spec|
  spec.name = 'post_pusher'
  spec.version = PostPusher::VERSION
  spec.authors = ['PatientsLikeMe']
  spec.email = ['engineers@patientslikeme.com']
  spec.homepage = 'https://www.patientslikeme.com'

  spec.summary = 'A tool to run a set of tasks after deploys'
  spec.description = 'A tool to run a set of tasks after deploys'

  spec.files = Dir["{bin,lib,db}/**/*", "README.md", "Rakefile"]
  spec.bindir = 'exe'
  spec.executables = ["post_push"]
  spec.test_files = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails" # TODO: get tests running without this.

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "minitest-spec-rails"
  spec.add_development_dependency "pry"
end
