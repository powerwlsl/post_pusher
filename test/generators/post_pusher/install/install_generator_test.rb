require 'test_helper'
require 'fileutils'
require 'rails/generators'
require 'generators/post_pusher/install/install_generator'

class PostPusher::Generators::InstallGeneratorTest < ::Rails::Generators::TestCase
  TEMP_DIR = File.expand_path("../../../../tmp", __dir__)
  tests PostPusher::Generators::InstallGenerator
  destination TEMP_DIR

  setup :prepare_destination

  it 'creates the migration file' do
    run_generator
    assert_migration "db/migrate/create_post_push_status.rb"
  end

  it 'skips the migration file if it already exists' do
    run_generator
    run_generator

    files = Dir.entries("#{TEMP_DIR}/db/migrate").reject { |f| f == '.' || f == '..' }

    assert_equal 1, files.length
    assert_migration "db/migrate/create_post_push_status.rb"
  end
end