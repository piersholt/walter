# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module TV
        # TV::Emulated
        class Emulated < Device::Emulated
          include Capabilities

          PROC = 'TV::Emulated'

          def handle_virtual_receive(message)
            command_id = message.command.d
            case command_id
            when DSP_SET
              true
            end

            super(message)
          end
        end
      end
    end
  end
end
