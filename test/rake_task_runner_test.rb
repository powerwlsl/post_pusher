require 'test_helper'
require_relative "../lib/post_pusher/rake_task_runner"

class RakeTaskRunnerTest < ActiveSupport::TestCase
  let(:log_path) { "test/dummy/log/post_push" }
  let(:log_file_name) { task.split(":").drop(1).join("_") << ".log" }
  let(:log_file) { "#{log_path}/#{log_file_name}" }
  let(:log) { File.read log_file }

  subject { RakeTaskRunner.new task }

  setup do
    Dir["#{log_path}/post_push/*.log"].each { |file| File.delete file }
    subject.work
  end

  describe "happy path" do
    let(:task) { "post_push:3:runnable_task" }

    it "should log the rake tasks output" do
      log.must_include "I'm wicked runnable, bro"
    end
  end

  describe "broken tasks" do
    let(:task) { "post_push:1:broken_task" }
    it "should also log busted tasks" do
      log.must_include "rake aborted"
      log.must_include "undefined method `shit_the_bed'"
    end
  end
end
