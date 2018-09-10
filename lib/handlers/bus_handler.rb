require 'singleton'
require 'messages'

class BusHandler
  include Event

  # METRICS = [BYTE_RECEIVED, FRAME_VALIDATED, FRAME_FAILED, MESSAGE_RECEIVED]

  # attr_reader :messages, :stats, :frames

  def self.i
    instance
  end

  def initialize(transitter)
    @transmitter = transitter
  end

  def disable_transitter
    @transmitter.disable
  end

  def inspect
    str_buffer = "<BusHandlerr>"
  end

  def update(action, properties)
    case action
    when BUS_OFFLINE
      LOGGER.info("BusHandler") { "Bus Offline! Disabling transmission." }
      disable_transitter
    end
  end
end
