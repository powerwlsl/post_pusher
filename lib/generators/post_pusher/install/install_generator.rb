module PostPusher
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the post_pusher migrations"

      def self.next_migration_number(path)
        Time.now.utc.to_s(:number)
      end

      def copy_migrations
        copy_migration "create_post_push_status"
      end

      protected

      def copy_migration(filename)
        if self.class.migration_exists?("db/migrate", "#{filename}")
          say_status("skipped", "Migration #{filename}.rb already exists")
        else
          migration_template "#{filename}.rb", "db/migrate/#{filename}.rb"
        end
      end
    end
  end
end
