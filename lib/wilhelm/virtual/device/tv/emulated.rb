# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module TV
        # TV::Emulated
        class Emulated < Device::Emulated
          include Capabilities

          PROC = 'TV::Emulated'

          SUBSCRIBE = [PING, IGNITION_REP].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)

            super(message)
          end

          # ED 04 FF 02 01 15
          # No using announce bit as emulated device is driven by IGN anyway...
          # @override Device::Capabilities::Ready.announce
          def announce
            super(to: :glo_h, status: 0x00)
          end
        end
      end
    end
  end
end
