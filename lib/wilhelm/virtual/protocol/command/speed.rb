# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::Speed
      class Speed < Base
        SPEED_UNIT = 'kmph'.freeze
        REV_UNIT = 'rpm'.freeze

        # @override
        def to_s
          "#{format('%-10s', sn)}\t" \
          "Speed: #{speed!}, " \
          "RPM: #{rpm!}"
        end

        def inspect
          "#{format('%-10s', sn)}\t" \
          "Speed: #{speed!}, " \
          "RPM: #{rpm!}"
        end

        private

        def parse_reading(reading, multiplier, unit)
          calculated_value = reading * multiplier
          "#{calculated_value}#{unit}"
        end

        def speed!
          @speed ||= parse_reading(*speed.value, 2, SPEED_UNIT)
        end

        def rpm!
          @rpm ||= parse_reading(*rpm.value, 100, REV_UNIT)
        end
      end
    end
  end
end
