# frozen_string_literal: true

# Comment
class Wilhelm::Virtual
  # Comment
  class AugmentedRadio < AugmentedDevice
    # User Input to be published
    module Actions
      include Wilhelm::Core::Command::Aliases
      include Wilhelm::Core::Command::Aliases
      # include ::Actions
      include Messaging::Constants
      include Messaging::API

      NEXT_PRESS = 0x00
      NEXT_HOLD = 0x40
      NEXT_RELEASE = 0x80

      PREV_PRESS = 0x10
      PREV_HOLD = 0x50
      PREV_RELEASE = 0x90

      private

      def action_bmbt_1_button(message)
        value = message.command.action.parameters[:totally_unique_variable_name].value

        # LOGGER.debug(PROC) { "#{MFL_FUNC}-#{value}" }
        case value
        when NEXT_HOLD
          scan_forward_start
        when PREV_HOLD
          scan_back_start
        when NEXT_RELEASE
          return scan_forward_stop if scanning?
          seek_forward
        when PREV_RELEASE
          return scan_back_stop if scanning?
          seek_back
        end
      end

      def action_mfl_function(message)
        # forward_press = 0x01
        forward_hold = 0x11
        forward_release = 0x21

        # back_press = 0x0B
        back_hold = 0x18
        back_release = 0x28

        value = message.command.action.parameters[:totally_unique_variable_name].value

        # LOGGER.debug(PROC) { "#{MFL_FUNC}-#{value}" }
        case value
        when forward_hold
          scan_forward_start
        when back_hold
          scan_back_start
        when forward_release
          return scan_forward_stop if scanning?
          seek_forward
        when back_release
          return scan_back_stop if scanning?
          seek_back
        end
      rescue StandardError => e
        LOGGER.error(self.class) { e }
        e.backtrace.each { |line| LOGGER.error(self.class) { line } }
      end

      def seek_forward
        thy_will_be_done!(MEDIA, SEEK_NEXT)
      end

      def seek_back
        thy_will_be_done!(MEDIA, SEEK_PREVIOUS)
      end

      def scan_forward_start
        scanning!
        thy_will_be_done!(MEDIA, SCAN_FORWARD_START)
      end

      def scan_forward_stop
        scanned!
        thy_will_be_done!(MEDIA, SCAN_FORWARD_STOP)
      end

      def scan_back_start
        scanning!
        thy_will_be_done!(MEDIA, SCAN_BACKWARD_START)
      end

      def scan_back_stop
        scanned!
        thy_will_be_done!(MEDIA, SCAN_BACKWARD_STOP)
      end

      def scanning?
        @scanning ||= false
      end

      def scanning!
        @scanning = true
      end

      def scanned!
        @scanning = false
      end
    end
  end
end
