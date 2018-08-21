class Commands
  # ID: 25 0x19
  class Key < BaseCommand
    attr_accessor :v1, :v2

    # SPEED_UNIT = 'kmph'.freeze
    # REV_UNIT = 'rpm'.freeze

    def initialize(id, props)
      super(id, props)

      @argument_map = map_arguments(@arguments)
      @v1 = parse_state(@argument_map[:v1])
      @v2 = parse_key(@argument_map[:v2])
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
      { state: @argument_map[:v1], key: @argument_map[:v2] }
    end

    # ---- Core ---- #

    # @override
    def to_s
      # speed = "#{v1}#{SPEED_UNIT}"
      # rev = "#{v2}#{REV_UNIT}"

      str_buffer = "#{sn}\t#{@v2}: #{@v1}"
      str_buffer
    end

    private

    def map_arguments(arguments)
      { v1: arguments[0],
        v2: arguments[1] }
    end

    def parse_state(reading)
      @state[reading.d]
    end

    def parse_key(reading)
      @key[reading.d]
    end
  end
end
