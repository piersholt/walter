# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedRadio < AugmentedDevice
    include API::Display
    include API::RadioLED
    include Actions
    include Notifications
    include Capabilities::OnBoardMonitor
    include Capabilities::Radio 

    PROC = 'AugmentedRadio'

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

  end
end
