# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        # Telephone::Emulated
        class Emulated < Device::Emulated
          include Capabilities
          include State
          include Received

          PROC = 'Telephone::Emulated'

          SUBSCRIBE = [PING, PONG, GFX_STATUS, TEL_DATA, TEL_OPEN].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            # LOGGER.debug(PROC) { "handle message id: #{command_id}" }
            case command_id
            when PONG
              logger.debug(PROC) { "Rx: Handling: PONG" }
              handle_announce(message)
            when GFX_STATUS
              logger.debug(PROC) { "Rx: Handling: GFX_STATUS" }
              handle_gfx_status(message)
            when TEL_DATA
              logger.debug(PROC) { "Rx: Handling: TEL_DATA" }
              handle_data_request(message.command)
            when TEL_OPEN
              logger.debug(PROC) { "Rx: Handling: TEL_OPEN" }
              handle_tel_open(message)
            end

            super(message)
          end
        end
      end
    end
  end
end
