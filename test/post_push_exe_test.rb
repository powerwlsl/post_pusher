require 'test_helper'
require_relative "../lib/post_push_cli"

class PostPushExeTest < ActiveSupport::TestCase
  let(:runnable_tasks)  { subject.send(:runnable_tasks) }
  let(:completed_tasks) { subject.send(:completed_tasks) }

  subject { PostPushCli.new }

  setup do
    ActiveRecord::Base.connection.execute("DELETE FROM post_push_statuses")
    ActiveRecord::Base.connection.execute("INSERT INTO post_push_statuses (task_name) VALUES ('post_push:2:completed_task')")
  end

  describe "#work" do
    # TODO: re-enable this.  Solano isn't finding all the tasks (I think),
    # so this one isn't available.  Make it work in a debug console with
    # bin/solano_run_gem_tests.  --sagotsky
    # it "should mark finished tasks so they dont rerun" do
    #   subject.work
    #   completed_tasks.must_include 'post_push:3:runnable_task'
    # end

    it "should not mark failed tasks as finished" do
      subject.work rescue nil
      completed_tasks.wont_include "post_push:1:broken_task"
    end
  end

  describe "#runnable_tasks" do
    it "should only return tasks that have not been run" do
      runnable_tasks.sort.must_equal(["post_push:1:broken_task", "post_push:3:runnable_task"])
    end

    it "should run the tasks in alphanumerical order" do
      runnable_tasks.sort.must_equal runnable_tasks
    end
  end

  describe "#completed_tasks" do
    it "should return tasks we know are completed" do
      completed_tasks.must_equal(["post_push:2:completed_task"])
    end
  end

  describe "#task_complete!" do
    setup do
      subject.send(:task_complete!, "post_push:the_new_rake_task")
    end

    it "should insert the rake task name into post_push_statuses when completed" do
      completed_tasks.sort.must_equal ["post_push:2:completed_task", "post_push:the_new_rake_task"]
    end
  end

  describe "#post_push_tasks" do
    it "should only return tasks that start with post_push:" do
      subject.send(:post_push_tasks).sort.must_equal(["post_push:1:broken_task", "post_push:2:completed_task", "post_push:3:runnable_task"])
    end
  end
end
