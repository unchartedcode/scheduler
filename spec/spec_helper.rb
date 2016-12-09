$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'scheduler'
require 'redis'
require 'sqlite3'
require 'coveralls'
Coveralls.wear!

ActiveRecord::Base.configurations = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(:test)

RSpec.configure do |config|
  config.before(:suite) do
    Scheduler.configure do |config|
      config.current_db = lambda {
        ActiveRecord::Base.connection_pool.spec.config[:db_key] || "default"
      }

      config.current_hostname = lambda {
        config = ActiveRecord::Base.connection_pool.spec.config
        config[:host_names].nil? ? config[:host] : config[:host_names].first
      }

      config.establish_connection = lambda { |db|
        ActiveRecord::Base.establish_connection({ adapter: :sqlite3, database: db })
      }

      config.with_connection = lambda { |db|
        # Not currently used in tests
      }
    end
  end
end

$redis = Redis.new(url: 'redis://localhost:6379/0', db: 8)
