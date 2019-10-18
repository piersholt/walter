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
            # case command_id
            # when 0x00
            #   logger.debug(PROC) { "Rx: 0x00 0x#{d2h(0x00)}" }
            # end

            super(message)
          end

          # ED 04 FF 02 01 15
          # No using announce bit as emulated device is driven by IGN anyway...
          def announce
            super(to: :glo_h, status: 0x00)
          end
        end
      end
    end
  end
end
