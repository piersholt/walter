# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::Temperature
      class Temperature < Base
        UNIT_CELSIUS = '°C'.freeze

        # @override
        def to_s
          "#{sn}\t" \
          "Ambient: #{ambient!}, " \
          "Coolant: #{coolant!}, " \
          "Unknown: #{unknown!}"
        end

        private

        def parse_reading(reading, unit)
          calculated_value = reading
          "#{calculated_value}#{unit}"
        end

        def ambient!
          @ambient ||= parse_reading(*ambient.value, UNIT_CELSIUS)
        end

        def coolant!
          @coolant ||= parse_reading(*coolant.value, UNIT_CELSIUS)
        end

        def unknown!
          @unknown ||= parse_reading(*unknown.value, UNIT_CELSIUS)
        end
      end
    end
  end
end
