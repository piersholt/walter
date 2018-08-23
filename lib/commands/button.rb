class Commands
  class Button < BaseCommand
    attr_reader :button_state

    def initialize(id, props)
      super(id, props)

      @argument_map = map_arguments(@arguments)
      @button_state = parse_button_state(@argument_map[:state])
    end

    # ---- Printable ---- #

    def bytes
      { state: @argument_map[:state] }
    end

    # ---- Core ---- #

    # @override
    def to_s
      str_buffer = "#{sn}\t#{@button_state}"
      str_buffer
    end

    private

    def map_arguments(arguments)
      { state: arguments[0] }
    end

    def parse_button_state(state)
      state_decimal = state.d
      # LOGGER.error(instance_variables)
      return @state[state_decimal] if @state.key?(state_decimal)
      "Unknown: #{state}"
    end
  end
end
