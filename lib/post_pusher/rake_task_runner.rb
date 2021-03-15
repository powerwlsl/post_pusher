require "pty"

class RakeTaskRunner
  BUFSIZE = 160

  def self.exec(task)
    RakeTaskRunner.new(task).tap(&:work)
  end

  attr_reader :task_name, :status

  def initialize(task_name)
    @task_name = task_name
  end

  def work
    @status = system(logging_rake_command)
  end

  private

  def rake_command
    "bundle exec rake #{task_name} RAILS_ENV=#{Rails.env}"
  end

  def logging_rake_command
    # PIPESTATUS is a bash and zsh construct. It stashes the exit statuses
    # of commands in a long pipe line like this one. $PIPESTATUS[0] is the
    # first exit status. $PIPESTATUS[1] would give us the exit status from
    # tee. So we're running rake, piping it into tee, and then making sure
    # to exit with the exit status we care about.
    "#{rake_command} 2>&1 | tee #{log_file_path} ; (exit ${PIPESTATUS[0]})"
  end

  def log_file_path
    logs = File.join(Rails.root, "log", "post_push")
    FileUtils.mkdir_p(logs) unless Dir.exist?(logs)
    File.join(logs, "#{log_file_name}.log")
  end

  def log_file_name
    task_name.split(":").drop(1).join("_")
  end
end
