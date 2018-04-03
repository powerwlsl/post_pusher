class PostPushInvokeGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  desc "Create a post push task that invokes another rake task"
  argument :rake_task_name, type: :string
  def create_post_push_invoke
    check_task!
    template "post_push_invoke.rake.erb", "lib/tasks/post_push/#{timestamp}_#{task_name}.rake"
  end

  private

  def check_task!
    Dir[File.join("lib/tasks/**/*.rake")].each do |f|
      begin
        load f
      rescue LoadError, StandardError
        nil
      end
    end

    return if rake_task_name.start_with?("db:seed") # TODO: figure out where this is defined and load it
    Rake::Task[rake_task_name] # raises an error if it's not present
  end

  def timestamp
    # print out the dates/timestamps we see in migrations
    # year month day hour minute second
    DateTime.now.strftime("%Y%m%d%H%M%S")
  end

  def task_name
    rake_task_name.tr ":", "_"
  end
end
