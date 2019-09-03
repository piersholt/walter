# frozen_string_literal: true

module Wilhelm
  module Services
    # Services::Timer
    class Timer
      include Helpers::Observation
      include Helpers::Time

      CLOCK_ID           = Process::CLOCK_MONOTONIC
      TIMER_UNIT         = :second
      ELAPSED_ERROR      = 'Unable to set elapsed time on running timer!'
      UPDATE_RATE        = 5
      MSG_TIMER_START    = '#start!'
      MSG_TIMER_STOP     = '#stop!'
      MSG_RESET_INTERVAL = '#reset_interval!'
      MSG_THREAD_START   = 'Thread running!'
      MSG_THREAD_STOP    = 'Thread stopping!'
      PROG               = 'Services::Timer'

      def initialize
        reset_interval!
      end

      def to_s
        formatted(elapsed_time)
      end

      def start!
        LOGGER.debug(PROG) { MSG_TIMER_START }
        return false if running?
        running!
        @start = clock_monotonic(TIMER_UNIT)
        accumulated_intervals
      end

      def stop!
        LOGGER.debug(PROG) { MSG_TIMER_STOP }
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

      def elapsed_time
        return accumulated_intervals unless running?
        accumulated_intervals + (clock_monotonic(TIMER_UNIT) - @start)
      end

      def elapsed_time=(interval, unit = 1000)
        LOGGER.debug(PROG) { "#elapsed_time=(#{interval})" }
        @intervals = [interval.fdiv(unit).round]
      end

      def periods
        time(elapsed_time)
      end

      def update_rate
        @thread&.thread_variable_get(:update_rate) || UPDATE_RATE
      end

      def update_rate=(value)
        @thread&.thread_variable_set(:update_rate, value)
      end

      private

      def running!
        @running = true
        threaded
      end

      def running?
        semaphore.synchronize do
          @running ||= false
        end
      end

      def stopping!
        @running = false
        @thread&.thread_variable_set(:running, false)
        @thread&.exit
        @thread = nil
      end

      def reset_interval!
        LOGGER.debug(PROG) { MSG_RESET_INTERVAL }
        return false if running?
        @start = -1
        @stop = -1
        true
      end

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

      def semaphore
        @semaphore ||= Mutex.new
      end

      def threaded
        return false if count_observers.zero?
        semaphore.synchronize do
          @thread ||= Thread.new do
            LOGGER.warn(PROG) { MSG_THREAD_START }
            last_time = elapsed_time
            while running?
              if elapsed_time > last_time
                changed
                notify_observers(:interval, self)
                last_time = elapsed_time
              end
              sleep(update_rate)
            end
            LOGGER.warn(PROG) { MSG_THREAD_STOP }
          end
        end
      end
    end
  end
end
