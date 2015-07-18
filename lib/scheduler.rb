require "scheduler/configuration"

module Scheduler
  # Configuration
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  require 'sidekiq/exception_handler'
  class SidekiqExceptionHandler
    extend Sidekiq::ExceptionHandler
  end

  # Log an exception.
  #
  # If your code is in a scheduled job, it is recommended to use the
  # error_context() method in Jobs::Base to pass the job arguments and any
  # other desired context.
  # See app/jobs/base.rb for the error_context function.
  def self.handle_job_exception(ex, context = {}, parent_logger = nil)
    context ||= {}
    parent_logger ||= SidekiqExceptionHandler
    puts ex

    parent_logger.handle_exception(ex, {
      current_db: Scheduler::Connection.current_db,
      current_hostname: Scheduler::Connection.current_hostname
    }.merge(context))
  end
end

require "active_support/dependencies"
require "active_record"
require "rails"
require "redis"
require "scheduler/version"

require_dependency 'scheduler/connection'
require_dependency 'scheduler/clock'
require_dependency 'scheduler/schedule'
require_dependency 'scheduler/schedule_info'
require_dependency 'scheduler/manager'
require_dependency 'scheduler/defer'
