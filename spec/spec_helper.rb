$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'scheduler'
require 'redis'
require 'sqlite3'

ActiveRecord::Base.configurations = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(:test)


module RailsMultisite
  module ConnectionManagement
    def self.current_db
      ActiveRecord::Base.connection_pool.spec.config[:db_key] || "default"
    end

    def self.current_hostname
      config = ActiveRecord::Base.connection_pool.spec.config
      config[:host_names].nil? ? config[:host] : config[:host_names].first
    end

    def self.establish_connection(db)
      ActiveRecord::Base.establish_connection({ adapter: :sqlite3, database: db })
    end
  end
end

$redis = Redis.new
