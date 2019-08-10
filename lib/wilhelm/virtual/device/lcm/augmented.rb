# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        # LCM::Augmented
        class Augmented < Device::Augmented
          include Wilhelm::Helpers::DataTools
          include API

          PUBLISH   = [ODO_REQ, VEH_LCM, LAMP_REP, CLUSTER_REP].freeze
          SUBSCRIBE = [ODO_REP, VEH_LCM_REQ, LAMP_REQ, CLUSTER_REQ].freeze

          PROC = 'LCM::Augmented'

          def handle_virtual_transmit(message)
            command_id = message.command.d
            return false unless publish?(command_id)
            case command_id
            when ODO_REQ
              logger.unknown(moi) { "Tx: ODO_REQ #{d2h(command_id)}" }
            when VEH_LCM
              logger.unknown(moi) { "Tx: VEH_LCM #{d2h(command_id)}" }
            when LAMP_REP
              logger.debug(moi) { "Tx: LAMP_REP #{d2h(command_id)}" }
              return false
            when CLUSTER_REP
              logger.unknown(moi) { "Tx: CLUSTER_REP #{d2h(command_id)}" }
            end
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when ODO_REP
              logger.unknown(moi) { "Rx: ODO_REP #{d2h(command_id)}" }
            when VEH_LCM_REQ
              logger.unknown(moi) { "Rx: VEH_LCM_REQ #{d2h(command_id)}" }
            when LAMP_REQ
              logger.unknown(moi) { "Rx: LAMP_REQ #{d2h(command_id)}" }
            when CLUSTER_REQ
              logger.unknown(moi) { "Rx: CLUSTER_REQ #{d2h(command_id)}" }
            end
          end
        end
      end
    end
  end
end
