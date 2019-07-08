# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # Diagnostics::Emulated
        class Emulated < Device::Emulated
          include Capabilities

          PROC = 'Diagnostics::Emulated'

          def handle_virtual_receive(message)
            command_id = message.command.d
            # return super if command_id == PING
            LOGGER.unknown(PROC) { "Handle? #{message.from} -> #{message.command.h}" }

            if Aliases::Groups::DIAGNOSTICS.include?(command_id)
              LOGGER.unknown(PROC) { "Diagnostic reply! #{message.command.h}" }
            end

          rescue StandardError => e
            LOGGER.error(PROC) { e }
            e.backtrace.each { |line| LOGGER.error(PROC) { line } }
          end
        end
      end
    end
  end
end
