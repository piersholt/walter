# frozen_string_literal: true

require_relative 'augmented/received'
require_relative 'augmented/sent'
require_relative 'augmented/state'

module Wilhelm
  module Virtual
    class Device
      module IKE
        # IKE::Augmented
        class Augmented < Device::Augmented
          include State
          include Capabilities
          include Sent
          include Received

          PUBLISH = [IGNITION_REP, ANZV_BOOL, ANZV_VAR, PROG].freeze
          SUBSCRIBE = [OBC_BOOL, OBC_VAR, PROG].freeze

          LogActually.is_all_around(:ike)
          LogActually.ike.i

          PROC = 'IKE::Augmented'

          def logger
            LogActually.ike
          end

          def handle_virtual_transmit(message)
            command_id = message.command.d
            return false unless publish?(command_id)
            case command_id
            when ANZV_VAR
              logger.debug(moi) { "Tx: ANZV_VAR (0x#{ANZV_VAR.to_s(16)})" }
              evaluate_anzv_var(message.command)
            when ANZV_BOOL
              logger.debug(moi) { "Tx: ANZV_BOOL (0x#{ANZV_BOOL.to_s(16)})" }
              evaluate_anzv_bool(message.command)
            when IGNITION_REP
              logger.debug(moi) { "Tx: IGNITION_REP (0x#{IGNITION_REP.to_s(16)})" }
              evaluate_ignition(message.command)
            when PROG
              logger.debug(moi) { "Tx: PROG (0x#{PROG.to_s(16)})" }
              evaluate_prog(message.command)
            end
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when OBC_VAR
              logger.debug(moi) { "Rx: OBC_VAR (0x#{OBC_VAR.to_s(16)})" }
              handle_obc_var(message.command)
            when OBC_BOOL
              logger.debug(moi) { "Rx: OBC_BOOL (0x#{OBC_BOOL.to_s(16)})" }
              handle_obc_bool(message.command)
            when PROG
              logger.debug(moi) { "Rx: PROG (0x#{PROG.to_s(16)})" }
              handle_prog(message.command)
            end
          end
        end
      end
    end
  end
end
