
module Wilhelm::Virtual::Alive
  include Wilhelm::Virtual::API::Alive

  # Think about device state and need to announce etc....
  # Some devices will only be ignition position II, some I...

  def announce
    LOGGER.warn(self.class) { 'Deprecated!' }
    announced!
    LOGGER.unknown(ident) { "HEY EVERYONE! COME SEE HOW GOOD #{@ident} looks!" }

    from_id = my_address

    # LOGGER.unknown(PROC) { "So, I #{@ident} of #{from_id} shall talk to #{to_id}" }

    pong({status: 0x01}, from_id, address(:glo_h))
  end

  def respond
    LOGGER.warn(self.class) { 'Deprecated!' }
    LOGGER.unknown(ident) { "Handling Ping." }
    # LOGGER.unknown(ident) { "So, I #{@ident} of #{my_address} shall talk to #{address(:glo_l)}" }

    pong({status: 0x00}, my_address, address(:glo_l))
    # LOGGER.unknown(ident) { "ping result => #{result}" }
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
