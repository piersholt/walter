module Alive
  include API::Alive

  # Think about device state and need to announce etc....
  # Some devices will only be ignition position II, some I...

  def announce
    announced!
    LOGGER.unknown(ident) { "HEY EVERYONE! COME SEE HOW GOOD #{@ident} looks!" }

    from_id = my_address
    to_id = address(:glo_h)

    # LOGGER.unknown(PROC) { "So, I #{@ident} of #{from_id} shall talk to #{to_id}" }

    pong({status: 0x01}, from_id, to_id)
  end

  def respond
    # LOGGER.unknown(ident) { "Handling Ping." }

    alt = AddressLookupTable.instance
    from_id = alt.get_address(ident)
    to_id = alt.get_address(:glo_l)

    # LOGGER.unknown(PROC) { "So, I #{@ident} of #{from_id} shall talk to #{to_id}" }

    pong({status: 0x00}, from_id, to_id)
  end

  private

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
end
