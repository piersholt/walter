# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module MFL
        # MFL::Augmented
        class Augmented < Device::Augmented
          include Wilhelm::Helpers::DataTools
          include State
          include Capabilities

          PUBLISH = [MFL_VOL, MFL_FUNC, MFL_VOL].freeze
          SUBSCRIBE = [].freeze

          PROC = 'MFL::Augmented'

          def handle_virtual_transmit(message)
            command_id = message.command.d
            return false unless publish?(command_id)

            case command_id
            when MFL_VOL
              logger.debug(moi) { "Tx: MFL_VOL (#{d2h(MFL_VOL)})" }
              evaluate_mfl_vol_button(message.command)
            when MFL_FUNC
              logger.debug(moi) { "Tx: MFL_FUNC (#{d2h(MFL_FUNC)})" }
              evaluate_mfl_func_button(message.command)
            end
          end
        end
      end
    end
  end
end
