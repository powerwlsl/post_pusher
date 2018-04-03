require "thor"
require_relative "../lib/post_pusher/rake_task_runner"

class PostPushCli < Thor
  desc "work", "Run remaining post push tasks"
  def work
    load_rails_env!
    succeeded = []
    failed = []

    runnable_tasks.each do |task|
      puts "Running task #{task}..."
      puts
      job = RakeTaskRunner.exec(task)

      if job.status
        task_complete!(task)
        succeeded << task
        success_message "Successfully ran #{task}"
      else
        error_message "Error in: #{task}"
        failed << task
      end

      puts "-" * 56
      puts
    end

    success_message "#{succeeded.size} tasks succeeded"
    error_message "Errors occured in #{failed.size} tasks:\n#{failed.join("\n")}" if failed.any?
  end

  desc "status", "List post push tasks and their status"
  option :new, default: false, desc: "Only show unrun tasks", type: :boolean
  option :done, default: false, desc: "Only show finished tasks", type: :boolean
  def status
    load_rails_env!

    unless options[:new]
      puts "Finished tasks:"
      puts completed_tasks.join "\n"
    end

    puts unless options[:new] || options[:done]

    unless options[:done]
      puts "Pending tasks:"
      puts runnable_tasks.join "\n"
    end

    puts
  end

  private

  def runnable_tasks
    post_push_tasks - completed_tasks
  end

  def connection
    ActiveRecord::Base.connection
  end

  def completed_tasks
    connection.select_values("SELECT task_name from post_push_statuses")
  end

  def task_complete!(task_name)
    connection.execute("INSERT INTO post_push_statuses (task_name) VALUES ('#{task_name}')")
  end

  def post_push_tasks
    rake_task_names.grep(/^post_push:/).sort
  end

  def rake_task_names
    rake_tasks.map(&:name)
  end

  def rake_tasks
    @rake_tasks ||= begin
      Rails.application.load_tasks
      Rake.application.tasks
    end
  end

  def load_rails_env!
    require(File.expand_path("config/environment", Dir.getwd)) unless Rails.application
  end

  def success_message(msg)
    puts "\e[32m#{msg}\e[0m" # green
  end

  def error_message(msg)
    puts "\e[31m#{msg}\e[0m" # red
  end
end
