require "bundler/gem_tasks"
require "rake/testtask"

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
load "rails/tasks/engine.rake"

import "#{Rails.root}/lib/tasks/dummy_tasks.rake" if Rails.env.test?

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: :test
