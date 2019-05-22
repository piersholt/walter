# frozen_string_literal: false

class Command
  # Command 0x38
  class MFLVolume < ParameterizedCommand
    # @override
    def button
      action.parameters[:direction].ugly
    end

    # @override
    def pretty
      action.parameters[:direction].pretty
    end
    # @override
    def magnitude
      action.parameters[:magnitude].ugly
    end

    # @override
    def magnitude_pretty
      action.parameters[:magnitude].pretty
    end

    def state
      :press
    end

    # @override
    # def to_s
    #   str_buffer = "#{sn}\t"
    #
    #   str_buffer << format_things
    # end
    #
    # def format_things
    #   value = action.value
    #   value = value.kind_of?(Numeric) ? d2h(value, true) : value
    #   "#{value} (#{action.bit_array.to_s}) #{pretty} #{state_pretty}"
    # end


  end
end

# Is 0b00
