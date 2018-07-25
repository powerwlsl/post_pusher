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
$ gem install post_pusher
```


## Im a dev, how can I use PostPusher? Is it hard?

No way buddy; getting your post push task ready for a release using PostPusher is super easy.

Steps:

- `rails g post_push_task task_name`
- add your code into the new task
- commit

Running the tasks:

- `bin/post_push work`

## How do I add this to my Rails app?

- Add PostPusher to your gemfile
- `bundle`
- `rails g post_pusher:install` (generate migration to create post_push_statuses table)
- Run migrations (creates records table)
- `bundle binstub post_pusher` (this enables you to be able to run `bin/post_push` by putting the post_push file in your bin directory)
- Commit your changes

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

