# frozen_string_literal: false

module Wilhelm
  module Virtual
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
      end
    end
  end
end
