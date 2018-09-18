class Commands
  # ID: 25 0x19
  class Speed < BaseCommand

    SPEED_UNIT = 'kmph'.freeze
    REV_UNIT = 'rpm'.freeze

    def initialize(id, props)
      super(id, props)
    end

    # ---- Core ---- #

    # @override
    def to_s
      fast = parse_reading(@speed, 2)
      fast = "#{fast}#{SPEED_UNIT}"

      rev = parse_reading(@rpm, 100)
      rev = "#{rev}#{REV_UNIT}"

      str_buffer = sprintf("%-10s", sn)
      str_buffer = str_buffer.concat("\tSpeed: #{fast}, RPM: #{rev}")
      str_buffer
    end

    def inspect
      fast = parse_reading(@speed, 2)
      fast = "#{fast}#{SPEED_UNIT}"

      rev = parse_reading(@rpm, 100)
      rev = "#{rev}#{REV_UNIT}"
      str_buffer = sprintf("%-10s", sn)
      str_buffer = str_buffer.concat("\tSpeed: #{fast}, RPM: #{rev}")
      str_buffer
    end

    private

    def map_arguments(arguments)
      { v1: arguments[0],
        v2: arguments[1] }
    end

    def parse_reading(reading, multiplier)
      reading * multiplier
    end
  end
end
