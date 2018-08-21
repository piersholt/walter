class Commands
  # ID: 25 0x19
  class Speed < BaseCommand
    attr_accessor :v1, :v2

    SPEED_UNIT = 'kmph'.freeze
    REV_UNIT = 'rpm'.freeze

    def initialize(id, props)
      super(id, props)

      @argument_map = map_arguments(@arguments)
      @v1 = parse_reading(@argument_map[:v1], 2)
      @v2 = parse_reading(@argument_map[:v2], 100)
    end

    # ---- Interface ---- #

    def ambient
      @v1
    end

    def coolant
      @v2
    end

    # ---- Printable ---- #

    def bytes
      { speed: @argument_map[:v1], rev: @argument_map[:v2] }
    end

    # ---- Core ---- #

    # @override
    def to_s
      speed = "#{v1}#{SPEED_UNIT}"
      rev = "#{v2}#{REV_UNIT}"

      str_buffer = "#{sn}\tSpeed: #{speed}, RPM: #{rev}"
      str_buffer
    end

    private

    def map_arguments(arguments)
      { v1: arguments[0],
        v2: arguments[1] }
    end

    def parse_reading(reading, multiplier)
      reading.d * multiplier
    end
  end
end
