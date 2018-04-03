class PostPushTaskGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  desc "Create a post push task"
  argument :task_name, type: :string
  def create_post_push_task
    template "post_push_task.rake.erb", "lib/tasks/post_push/#{timestamp}_#{task_name}.rake"
  end

  private

  def timestamp
    # print out the dates/timestamps we see in migrations
    # year month day hour minute second
    DateTime.now.strftime("%Y%m%d%H%M%S")
  end
end
