$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "active_support"
require File.expand_path("dummy/config/environment.rb", __dir__)

ActiveSupport::TestCase.test_order = :random # if we don't set this, active_support gives a warning

require "minitest/autorun"
require 'minitest/reporters'
require "post_pusher"
require "rake"
require "bundler/gem_tasks"
require "rake/testtask"
require "pry"

Rails.env = "test"

if ENV['BUILD_NUMBER']
  Minitest::Reporters.use!(
    [MiniTest::Reporters::DefaultReporter.new, MiniTest::Reporters::JUnitReporter.new('test/reports')],
    ENV,
    Minitest.backtrace_filter,
  )
else
  Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new, ENV, Minitest.backtrace_filter)
end

class ActiveSupport::TestCase
  extend MiniTest::Spec::DSL
end

if defined?(ActiveRecord::MigrationContext)
  ActiveRecord::MigrationContext.new(File.expand_path("dummy/db/migrate", __dir__)).up
else
  ActiveRecord::Migrator.migrate File.expand_path("dummy/db/migrate", __dir__)
end
