module Scheduler
  class Clock
    def self.start!
      manager = Scheduler::Manager.new
      Scheduler::Manager.discover_schedules.each do |schedule|
        manager.ensure_schedule!(schedule)
      end

      Thread.new do
        while true
          begin
            manager.tick
          rescue => e
            # the show must go on
            Scheduler::Manager.handle_exception(e)
          end
          sleep 1
        end
      end
    end
  end
end
