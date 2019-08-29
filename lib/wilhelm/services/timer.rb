# frozen_string_literal: true

module Wilhelm
  module Services
    # Services::Timer
    class Timer
      CLOCK_ID        = Process::CLOCK_MONOTONIC
      TIMER_UNIT      = :second
      DURATION_BASES  = [60, 60, 24].freeze
      TIMER_MASK      = '%.2i'
      TIMER_DELIMITER = ':'
      ELAPSED_ERROR   = 'Unable to set elapsed time on running timer!'

      def initialize
        reset_interval!
      end

      def reset_interval!
        LOGGER.unknown(self.class) { '#reset_interval!' }
        # return false if started?
        @start = -1
        @stop = -1
        true
      end

      def start!
        LOGGER.unknown(self.class) { '#start!' }
        return false if started?
        @start = clock_monotonic(TIMER_UNIT)
        accumulated_intervals
      end

      def stop!
        LOGGER.unknown(self.class) { '#stop!' }
        return false unless started?
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

      def started?
        return false unless @start
        return false if @start.negative?
        true
      end

      def stopped?
        return false if started? && @stop.negative?
        return false if @stop.positive?
        true
      end

      def elapsed_time=(interval, unit = 1000)
        LOGGER.unknown(self.class) { "#elapsed_time=(#{interval})" }
        LOGGER.warn(self) { ELAPSED_ERROR } if started?
        @intervals = [interval.fdiv(unit).round]
      end

      def elapsed_time
        return accumulated_intervals if stopped?
        accumulated_intervals + (clock_monotonic(TIMER_UNIT) - @start)
      end

      def duration
        n = elapsed_time
        DURATION_BASES.collect do |b|
          n, d = n.divmod(b)
          d
        end
      end

      def to_s
        duration.reverse.collect do |i|
          format(TIMER_MASK, i)
        end&.join(TIMER_DELIMITER)
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
