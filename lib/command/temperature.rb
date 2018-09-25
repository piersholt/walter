class Commands
  # ID: 25 0x19
  class Temperature < BaseCommand
    attr_accessor :a1, :a2, :a3

    TEMP_UNIT = '°C'.freeze

    def initialize(id, props)
      super(id, props)
      @argument_map = map_arguments(@arguments)

      # Ambient?
      @a1 = parse_reading(@argument_map[:a1])
      # Coolant?
      @a2 = parse_reading(@argument_map[:a2])
      # Always 0?
      @a3 = parse_reading(@argument_map[:a3])
    end

    def ambient
      @a1
    end

    def coolant
      @a2
    end

    def bytes
      { ambient: @argument_map[:a1], coolant: @argument_map[:a2], unknown: @argument_map[:a3] }
    end

    # @override
    def to_s
      ambient = "#{a1}#{TEMP_UNIT}"
      coolant = "#{a2}#{TEMP_UNIT}"
      other = "#{a3}#{TEMP_UNIT}"

      str_buffer = "#{sn}\tAmbient: #{ambient}, Coolant: #{coolant}, Other: #{other}"
      str_buffer
    end

    private

    def map_arguments(arguments)
      { a1: arguments[0],
        a2: arguments[1],
        a3: arguments[2] }
    end

    def parse_reading(reading)
      reading.d
    end
  end
end
