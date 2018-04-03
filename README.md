## What Is PostPusher?

A sweet gem that makes post pushing way easier.

## Installation

Add this line to your application's Gemfile:

```
gem 'post_pusher'
```

And then execute:

```
$ bundle
```

Or install it yourself with:

```
gem install post_pusher
```


## Im a dev, how can I use PostPusher? Is it hard?

No way buddy; getting your post push task ready for a release using PostPusher is super easy.

Steps:
-rails g post_push_task task_name
-add your code into the new task
-create a jira ticket for your post push and link it to the appropriate release ticket

Old Process
-Create the task you want run as a PPT
-Some people would then message Bryan or the Scrummaster/mistress to let us know about it (not required but some still did, costing a few minutes)
-Scrummaster/mistress spends a little time on Thursday ensuring all post push tasks are setup and linked to the Release ticket
-Scrummaster/mistress a little more time on friday making sure everyone had their tasks listed on jira and that they were linked
-monday morning each of the tasks are run individually after a successful deploy, each task is then individually run again against current and then master

New Process
-Create the task you want to run as a PPT
-Create JIRA ticket and link to Ops/Release ticket
-Run bin/post_push on prod/current/master after a successful deploy on Monday

## How does it work?

Each and every post push task going forward will be generated using the PostPusher gem. Once a rake file has been generated, it will be stored within your apps lib/tasks/post_push folder.

To keep track of what has and has not been run yet, we’ll be storing the name of each rake task within a table once theyve successfully been executed. A list of all available rake tasks will be gathered and compared against the names in our table to be narrowed down into ‘runnable tasks’. Upon running bin/post_push, all ‘runnable tasks’ will be executed. The output/result of each task will be logged to both terminal as well as a .log file. These log files will be stored in your apps log/post_push directory.

## How do I add this to my rails app?

-Add PostPusher to your gemfile
-bundle
-Run migrations (creates records table)
-bundle binstub post_pusher (this enables you to be able to run bin/post_push by putting the post_push file in your bin directory)
-Commit your changes

## Running Tests

1. Change to the gem's directory
2. Run `bundle`
3. Run `rake`

## Release Process

Once pull request is merged to master, on latest master:

1. Update CHANGELOG.md. Version: [ major (breaking change: non-backwards
   compatible release) | minor (new features) | patch (bugfixes) ]
2. Update version in lib/post\_pusher/version.rb
3. Release by running `bundle exec rake release`

