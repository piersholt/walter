# frozen_string_literal: true

# Comment
class Virtual
  class SimulatedRadio < EmulatedDevice
    include Capabilities::Radio

    PROC = 'SimulatedRadio'.freeze
    SUBSCRIBE = [PING, MFL_VOL, MFL_FUNC, BMBT_A, SRC_CTL, SRC_SND, MENU_GFX, CDC_REP, TEL_DATA].freeze

    def logger
      LogActually.rad
    end

    def subscribe?(command_id)
      SUBSCRIBE.include?(command_id)
    end

    def handle_virtual_receive(message)
      # logger.fatal(PROC) { "handle_virtual_receive: #{message.command.d}" }
      command_id = message.command.d
      return false unless subscribe?(command_id)
      case command_id
      when MFL_FUNC
        # logger.debug(PROC) { "Rx: Handling: MFL-FUNC" }
        false
      when MFL_VOL
        # logger.debug(PROC) { "Rx: Handling: MFL-FUNC" }
        false
      when BMBT_A
        # logger.debug(PROC) { "Rx: Handling: BMBT-1" }
        false
      when BMBT_B
        false
      when MENU_GFX
        # logger.debug(PROC) { "Rx: Handling: MENU_GFX"  }
        false
      end

      super(message)
    rescue StandardError => e
      logger.error(PROC) { e }
      e.backtrace.each { |line| logger.error(PROC) { line } }
    end
  end
end
