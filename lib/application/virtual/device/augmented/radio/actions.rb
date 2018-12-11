# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedRadio < AugmentedDevice
    # User Input to be published
    module Actions
      include CommandAliases
      include CommandGroups
      include ::Actions

      def handle_message(message)
        command_id = message.command.d
        # return super if command_id == PING
        LOGGER.debug(PROC) { "Handle? #{message.from} -> #{message.command.h}" }

        case command_id
        when MFL_FUNC
          LOGGER.debug(PROC) { "Handling: MFL-FUNC" }
          forward_back(message)
        when BMBT_A
          LOGGER.debug(PROC) { "BMBT-1 not implemented." }
        when BMBT_B
          LOGGER.debug(PROC) { "BMBT-2 not implemented." }
        when SRC_CTL
          LOGGER.debug(PROC) { "SRC_CTL not implemented." }
        end
      rescue StandardError => e
        LOGGER.error(self.class) { e }
        e.backtrace.each { |line| LOGGER.error(self.class) { line } }
      end

      private

      def forward_back(message)
        # forward_press = 0x01
        forward_hold = 0x11
        forward_release = 0x21

        # back_press = 0x0B
        back_hold = 0x18
        back_release = 0x28

        value = message.command.totally_unique_variable_name

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
        thy_will_be_done!(:seek_forward)
      end

      def seek_back
        thy_will_be_done!(:seek_back)
      end

      def scan_forward_start
        scanning!
        thy_will_be_done!(:scan_forward_start)
      end

      def scan_forward_stop
        scanned!
        thy_will_be_done!(:scan_forward_stop)
      end

      def scan_back_start
        scanning!
        thy_will_be_done!(:scan_back_start)
      end

      def scan_back_stop
        scanned!
        thy_will_be_done!(:scan_back_stop)
      end

      def thy_will_be_done!(command)
        action = Messaging::Action.new(topic: :media, name: command)
        fuckin_send_it_lads!(action)
      end

      def fuckin_send_it_lads!(action)
        LOGGER.debug(PROC) { "sending: #{action}"}
        Publisher.send(action.topic, action.to_yaml)
      rescue StandardError => e
        LOGGER.error(self.class) { e }
        e.backtrace.each { |line| LOGGER.error(self.class) { line } }
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
