# frozen_string_literal: true

require_relative 'emulated/received'

module Wilhelm
  module Virtual
    class Device
      module Radio
        # Radio::Emulated
        class Emulated < Device::Emulated
          include Wilhelm::Helpers::DataTools
          include Capabilities
          include Received

          PROC = 'Radio::Emulated'

          SUBSCRIBE = [
            PING,
            MENU_GT,
            MFL_VOL,
            MFL_FUNC,
            BMBT_I, BMBT_A, BMBT_B,
            DIA_HELLO, DIA_COD_READ
          ].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)

            case command_id
            when MENU_GT
              logger.debug(PROC) { "Rx: MENU_GT 0x#{d2h(MENU_GT)}" }
              handle_menu_gt(message.command)
            when MFL_FUNC
              logger.debug(PROC) { "Rx: MFL_FUNC 0x#{d2h(MFL_FUNC)}" }
              handle_mfl_func(message.command)
            when MFL_VOL
              logger.debug(PROC) { "Rx: MFL_VOL 0x#{d2h(MFL_VOL)}" }
              handle_mfl_vol(message.command)
            when BMBT_A
              logger.debug(PROC) { "Rx: BMBT_A 0x#{d2h(BMBT_A)}" }
              handle_bmbt_button_1(message.command)
            when DIA_HELLO
              logger.debug(PROC) { "Rx: DIA_HELLO 0x#{d2h(DIA_HELLO)}" }
              info!
            when DIA_COD_READ
              logger.debug(PROC) { "Rx: DIA_COD_READ 0x#{d2h(DIA_COD_READ)}" }
              coding!
            end

            super(message)
          end
        end
      end
    end
  end
end
