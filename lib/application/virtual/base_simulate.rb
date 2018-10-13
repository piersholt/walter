class Virtual
  module BaseSimulate
    include API::Alive

    PROC = 'BaseSimulate'.freeze

    def check_message(message)
      command_id = message.command.d
      case command_id
      when 0x01
        respond
      when 0x11
        announce?(message.command)
      end
    end

    def already_announced?
      if @already_announced.nil? || @already_announced == false
        false
      else
        true
      end
    end

    def announced!
      @already_announced = true
    end

    def announce?(ignition)
      return false if already_announced?
      announce if ignition.accessory?
    end

    def announce
      announced!
      LOGGER.warn(ident) { "HEY EVERYONE! COME SEE HOW GOOD #{@ident} looks!" }

      alt = AddressLookupTable.instance
      from_id = alt.get_address(ident)
      to_id = alt.get_address(:glo_h)

      # LOGGER.warn(PROC) { "So, I #{@ident} of #{from_id} shall talk to #{to_id}" }

      pong({status: 0x01}, from_id, to_id)
    end

    def respond
      LOGGER.warn(PROC) { "So, I #{@ident} had best simulateth a pongeth!" }

      alt = AddressLookupTable.instance
      from_id = alt.get_address(ident)
      to_id = alt.get_address(:glo_l)

      # LOGGER.warn(PROC) { "So, I #{@ident} of #{from_id} shall talk to #{to_id}" }

      pong({status: 0x00}, from_id, to_id)
    end
  end
end
