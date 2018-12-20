# frozen_string_literal: true

# Comment
class Virtual
  class SimulatedCDC < EmulatedDevice
    # Comment
    module State
      include Stateful

      def default_state
        DEFAULT_STATE.dup
      end

      def current_state
        state
      end

      # Byte 1
      def current_control
        state[:control]
      end

      # Byte 6
      def current_track
        state[:track]
      end

      # Calculated Values
      def next_track
        current_track + 1
      end

      def previous_track
        current_track - 1
      end

      # Intervals for FFD/RWD vs. Next/Previous
      def only_skip_track?
        elapased_time <= SCAN_THRESHOLD_SECONDS
      end
    end
  end
end
