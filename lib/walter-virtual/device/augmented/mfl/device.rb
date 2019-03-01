# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedMFL < AugmentedDevice
    include State
    include Capabilities::MultiFunctionWheel
    
    PUBLISH = [MFL_VOL, MFL_FUNC].freeze
    SUBSCRIBE = [].freeze

    PROC = 'AugmentedMFL'

    # TODO: move to superclass
    def moi
      ident.upcase
    end

    def logger
      LogActually.mfl
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
      when MFL_FUNC
        logger.debug(moi) { "Tx: MFL_FUNC (#{DataTools.d2h(MFL_FUNC)})" }
        handle_mfl_func_button(message.command)
      when MFL_VOL
        logger.debug(moi) { "Tx: MFL_VOL (#{DataTools.d2h(MFL_VOL)})" }
        handle_mfl_vol_button(message.command)
      end
    end

    # TODO: move to superclass
    def handle_virtual_receive(message)
      command_id = message.command.d
      return false unless subscribe?(command_id)
    end
  end
end
