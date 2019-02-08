# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedBMBT < AugmentedDevice
    include Capabilities::OnBoardMonitor
    include State

    PUBLISH = [
      BMBT_A, BMBT_B, BMBT_I
    ].freeze

    SUBSCRIBE = [].freeze

    PROC = 'AugmentedBMBT'

    def moi
      ident.upcase
    end

    def logger
      LogActually.bmbt
    end

    def publish?(command_id)
      PUBLISH.include?(command_id)
    end

    def subscribe?(command_id)
      SUBSCRIBE.include?(command_id)
    end

    def handle_virtual_transmit(message)
      command_id = message.command.d
      return false unless publish?(command_id)

      case command_id
      when BMBT_A
        logger.debug(moi) { "Tx: BMBT A (#{DataTools.d2h(BMBT_A)})" }
        handle_bmbt_1_button(message.command)
      when BMBT_B
        # nothing
      when BMBT_I
        # nothing
      end
    end

    def handle_virtual_receive(message)
      command_id = message.command.d
      return false unless subscribe?(command_id)
    end
  end
end
