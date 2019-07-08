# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        # BMBT::Augmented
        class Augmented < Device::Augmented
          include Wilhelm::Helpers::DataTools
          include Capabilities
          include Sent
          include Received

          PUBLISH = [BMBT_A, BMBT_B, MFL_VOL].freeze
          SUBSCRIBE = [RAD_LED].freeze

          PROC = 'BMBT::Augmented'

          def handle_virtual_transmit(message)
            command_id = message.command.d
            return false unless publish?(command_id)

            case command_id
            when BMBT_A
              logger.debug(moi) { "Tx: BMBT A (#{d2h(BMBT_A)})" }
              evaluate_bmbt_1_button(message.command)
            when BMBT_B
              logger.debug(moi) { "Tx: BMBT A (#{d2h(BMBT_B)})" }
              evaluate_bmbt_2_button(message.command)
            when MFL_VOL
              logger.debug(moi) { "Tx: MFL_VOL (#{d2h(MFL_VOL)})" }
              evaluate_mfl_vol_button(message.command)
            end
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when RAD_LED
              handle_rad_led(message.command)
            end
          end
        end
      end
    end
  end
end
