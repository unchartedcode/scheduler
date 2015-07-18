# Uncharted Scheduler

Uncharted Scheduler allows for scheduling of recurring jobs with [Sidekiq](https://github.com/mperham/sidekiq). This library was extracted out of [Discourse](https://github.com/discourse/discourse).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uncharted-scheduler',
    git: 'https://github.com/unchartedcode/scheduler'
```

And then execute:

    $ bundle

## Usage

Add this to the bottom fo your `sidekiq.rb` initializer.

```ruby
require 'scheduler'
Scheduler::Clock.start!
```

Then for each Sidekiq job that you want to schedule add

```ruby
extend Scheduler::Schedule
```

along with an interval for how often you want it to run

```ruby
every 2.hours
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/unchartedcode/scheduler.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
