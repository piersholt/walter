require 'singleton'
require 'application/messages'

class InterfaceHandler
  include Event

  # METRICS = [BYTE_RECEIVED, FRAME_RECEIVED, FRAME_FAILED, MESSAGE_RECEIVED]

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
    str_buffer = "<InterfaceHandlerr>"
  end

  def update(action, properties)
    case action
    when BUS_OFFLINE
      LOGGER.info("InterfaceHandler") { "Bus Offline! Disabling transmission." }
      disable_transitter
    end
  end
end
