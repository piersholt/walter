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
      UPDATE_RATE = 5

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
        @thread&.thread_variable_set(:running, false)
        @thread&.exit
        @thread = nil
      end

      def semaphore
        @semaphore ||= Mutex.new
      end

      def logger
        LOGGER
      end

      def threaded
        return false if count_observers.zero?
        semaphore.synchronize do
          @thread ||= Thread.new do
            LOGGER.warn(self) { 'Thread running!' }
            last_time = elapsed_time
            while running?
              if elapsed_time > last_time
                changed
                notify_observers(:interval, self)
                last_time = elapsed_time
              end
              sleep(update_rate)
            end
            LOGGER.warn(self) { 'Thread stopping!' }
          end
        end
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

      def update_rate
        @thread&.thread_variable_get(:update_rate) || UPDATE_RATE
      end

      def update_rate=(value)
        @thread&.thread_variable_set(:update_rate, value)
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
