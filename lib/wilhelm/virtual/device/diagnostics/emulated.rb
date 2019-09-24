# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # Diagnostics::Emulated
        class Emulated < Device::Emulated
          include Wilhelm::Virtual::Constants::Command::Groups
          include Capabilities

          PROC = 'Diagnostics::Emulated'

          SUBSCRIBE = DIAGNOSTICS

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            # LOGGER.unknown(PROC) { "#handle_virtual_receive(#{command_id})" }

            super(message)
          rescue StandardError => e
            LOGGER.error(PROC) { e }
            e.backtrace.each { |line| LOGGER.error(PROC) { line } }
          end
        end
      end
    end
  end
end
