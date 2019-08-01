# frozen_string_literal: true

require_relative 'emulated/state'
require_relative 'emulated/received'

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

          SUBSCRIBE = [PING, PONG, TEL_DATA, TEL_OPEN].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            # LOGGER.debug(PROC) { "handle message id: #{command_id}" }
            case command_id
            when PONG
              logger.debug(PROC) { "Rx: PONG 0x#{d2h(PONG)}" }
              handle_pong(message)
            when INPUT
              logger.debug(PROC) { "Rx: INPUT 0x#{d2h(INPUT)}" }
              handle_input(message.command)
            when TEL_OPEN
              logger.debug(PROC) { "Rx: TEL_OPEN 0x#{d2h(TEL_OPEN)}" }
              handle_tel_open(message)
            end

            super(message)
          end
        end
      end
    end
  end
end
