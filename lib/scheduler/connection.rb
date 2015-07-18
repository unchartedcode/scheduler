module Scheduler
  class Connection
    class << self
      def current_db
        ActiveRecord::Base.connection_pool.spec.config[:db_key] || "default"
      end

      def current_hostname
        config = ActiveRecord::Base.connection_pool.spec.config
        config[:host_names].nil? ? config[:host] : config[:host_names].first
      end

      def establish_connection(db)
        config = ActiveRecord::Base.configurations[db]
        ActiveRecord::Base.establish_connection(config)
      end

      def with_connection(db)
        old = current_db
        connected = ActiveRecord::Base.connection_pool.connected?

        establish_connection(:db => db) unless connected && db == old
        rval = yield db

        unless connected && db == old
          ActiveRecord::Base.connection_handler.clear_active_connections!

          establish_connection(:db => old)
          ActiveRecord::Base.connection_handler.clear_active_connections! unless connected
        end

        rval
      end
    end
  end
end
