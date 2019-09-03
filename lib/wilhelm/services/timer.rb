# frozen_string_literal: true

module Wilhelm
  module Services
    # Services::Timer
    class Timer
      include Helpers::Observation
      include Helpers::Time

      CLOCK_ID        = Process::CLOCK_MONOTONIC
      TIMER_UNIT      = :second
      ELAPSED_ERROR   = 'Unable to set elapsed time on running timer!'

      def initialize
        reset_interval!
      end

      def reset_interval!
        LOGGER.unknown(self) { '#reset_interval!' }
        return false if running?
        @start = -1
        @stop = -1
        true
      end

      def running?
        semaphore.synchronize do
          @running ||= false
        end
      end

      def running!
        @running = true
        threaded
      end

      def stopping!
        @running = false
      end

      def semaphore
        @semaphore ||= Mutex.new
      end

      def logger
        LOGGER
      end

      def threaded
        return false if @thread
        @thread = Thread.new do
          LOGGER.unknown(self) { 'Thread running!' }
          last_time = elapsed_time
          while running?
            if elapsed_time > last_time
              changed
              notify_observers(:interval, self)
              last_time = elapsed_time
            end
            sleep(30)
          end
          LOGGER.unknown(self) { 'Thread stopping!' }
        end
        @thread = nil
      end

      def start!
        LOGGER.unknown(self) { '#start!' }
        return false if running?
        running!
        @start = clock_monotonic(TIMER_UNIT)
        accumulated_intervals
      end

      def stop!
        LOGGER.unknown(self) { '#stop!' }
        return false unless running?
        stopping!
        @stop = clock_monotonic(TIMER_UNIT)
        interval(@start, @stop)
        reset_interval!
        accumulated_intervals
      end

      def reset!
        stop!
        @intervals = [0]
        elapsed_time
      end

      def elapsed_time=(interval, unit = 1000)
        LOGGER.unknown(self) { "#elapsed_time=(#{interval})" }
        LOGGER.warn(self) { ELAPSED_ERROR } if running?
        @intervals = [interval.fdiv(unit).round]
      end

      def elapsed_time
        return accumulated_intervals unless running?
        accumulated_intervals + (clock_monotonic(TIMER_UNIT) - @start)
      end

      def periods
        time(elapsed_time)
      end

      def to_s
        formatted(elapsed_time)
      end

      private

      def interval(time_start, time_stop)
        intervals << time_stop - time_start
      end

      def intervals
        @intervals ||= [0]
      end

      def accumulated_intervals
        intervals.reduce(&:+)
      end

      def clock_monotonic(unit = TIMER_UNIT)
        Process.clock_gettime(CLOCK_ID, unit)
      end
    end
  end
end
