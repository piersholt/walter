# frozen_string_literal: true

# Comment
module Wilhelm
  class Virtual
    # Comment
    class AugmentedBMBT < AugmentedDevice
      include Capabilities::OnBoardMonitor
      include Sent

      PUBLISH = [BMBT_A, BMBT_B, BMBT_I, MFL_VOL].freeze
      SUBSCRIBE = [RAD_LED].freeze

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
        when MFL_VOL
          logger.debug(moi) { "Tx: MFL_VOL (#{DataTools.d2h(MFL_VOL)})" }
          handle_mfl_vol_button(message.command)
        end
      end

      # TODO: move to superclass
      def handle_virtual_receive(message)
        command_id = message.command.d
        return false unless subscribe?(command_id)
        case command_id
        when RAD_LED
          handle_rad_led(message.command)
        end
      end

      def handle_rad_led(command)
        case command.led?
        when :on
          on!
        when :radio
          on!
        when :tape
          on!
        when :reset
          off!
        when :off
          off!
        end
      end

      def on!
        @power = true
      end

      def off!
        @power = false
      end

      def power?
        @power ||= false
      end
    end
  end
end
