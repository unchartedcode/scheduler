require 'redlock'
require 'byebug'

# Cross-process locking using Redis.
class DistributedMutex
  def self.synchronize(key, redis=nil, timeout=60000, &blk)
    self.new(key, redis, timeout).synchronize(&blk)
  end

  def initialize(key, redis=nil, timeout=60000)
    @key = key
    @redis = redis || $redis
    @lock_manager = Redlock::Client.new([@redis])
    @timeout = timeout
    @mutex = Mutex.new
  end

  # NOTE wrapped in mutex to maintain its semantics
  def synchronize
    @mutex.lock
    @lock_manager.lock(@key, @timeout) do |lock_info|
      yield lock_info
    end
  ensure
    @mutex.unlock
  end
end
