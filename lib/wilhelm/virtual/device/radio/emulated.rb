# frozen_string_literal: true

# Comment
module Wilhelm
  module Virtual
    class Device
      module Radio
        # Comment
        class Emulated < Device::Emulated
          include Capabilities

          PROC = 'SimulatedRadio'
          SUBSCRIBE = [PING, MENU_GFX].freeze

          def logger
            LOGGER
          end

          def subscribe?(command_id)
            SUBSCRIBE.include?(command_id)
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when MENU_GFX
              logger.debug(PROC) { 'Rx: Handling: MENU_GFX' }
              handle_menu_gfx(message.command)
            end

            super(message)
          rescue StandardError => e
            logger.error(PROC) { e }
            e.backtrace.each { |line| logger.error(PROC) { line } }
          end

          def handle_menu_gfx(command)
            case Kernel.format('%8.8b', command.config.value)[7]
            when '1'
              acknowledge_menu
            end
          rescue StandardError => e
            logger.error(PROC) { e }
            e.backtrace.each { |line| logger.error(PROC) { line } }
          end
        end
      end
    end
  end
end
