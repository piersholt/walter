# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        # LCM::Emulated
        class Emulated < Device::Emulated
          include Wilhelm::Helpers::DataTools
          include Capabilities

          SUBSCRIBE = [
            ODO_REP, VEH_LCM_REQ, LAMP_REQ, CLUSTER_REQ,
            DIA_HELLO, DIA_COD_READ, DIA_STATUS
          ].freeze

          PROC = 'LCM::Emulated'

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when ODO_REP
              logger.debug(moi) { "Rx: ODO_REP #{d2h(command_id)}" }
            when VEH_LCM_REQ
              logger.debug(moi) { "Rx: VEH_LCM_REQ #{d2h(command_id)}" }
            when LAMP_REQ
              logger.debug(moi) { "Rx: LAMP_REQ #{d2h(command_id)}" }
            when CLUSTER_REQ
              logger.debug(moi) { "Rx: CLUSTER_REQ #{d2h(command_id)}" }
            when DIA_HELLO
              logger.debug(moi) { "Rx: DIA_HELLO #{d2h(command_id)}" }
              info!
            when DIA_COD_READ
              logger.debug(moi) { "Rx: DIA_COD_READ #{d2h(command_id)}" }
              coding!
            when DIA_STATUS
              logger.debug(moi) { "Rx: DIA_STATUS #{d2h(command_id)}" }
              status!
            end
          end
        end
      end
    end
  end
end
