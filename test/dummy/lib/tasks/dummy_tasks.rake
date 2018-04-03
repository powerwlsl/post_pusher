namespace :post_push do
  namespace "3" do
    desc "This task can be run and should be visible to tests."
    task runnable_task: :environment do
      puts "I'm wicked runnable, bro"
    end
  end

  namespace "2" do
    desc "This one already ran"
    task completed_task: :environment do
      puts "Don't rerun me"
    end
  end

  namespace "1" do
    desc "This one wont run and will remain in the runnable queue forevaaah"
    task broken_task: :environment do
      shit_the_bed(true)
    end
  end
end

namespace :not_a_post_push_task_at_all do
  namespace "0" do
    desc "bin/post_push should ignore me"
    task just_an_ordinary_rake_task_minding_its_own_business: :environment do
      raise "You shouldn't have run this one"
    end
  end
end
