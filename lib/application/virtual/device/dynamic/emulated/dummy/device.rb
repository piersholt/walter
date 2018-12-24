# frozen_string_literal: true

# Comment
class Virtual
  class EmulationDummy < EmulatedDevice
    PROC = 'EmulationDummy'.freeze

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when 266
        false
      end

      super(message)
    end
  end
end
