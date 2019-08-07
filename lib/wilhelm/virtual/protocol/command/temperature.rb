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
          "Ambient: #{parse_reading(*ambient.value, UNIT_CELSIUS)}, " \
          "Coolant: #{parse_reading(*coolant.value, UNIT_CELSIUS)}, " \
          "Unknown: #{parse_reading(*unknown.value, UNIT_CELSIUS)}"
        end

        private

        def parse_reading(reading, unit)
          calculated_value = reading
          "#{calculated_value}#{unit}"
        end
      end
    end
  end
end
