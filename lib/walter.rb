# core dependencies
require 'observer'
require 'thread'

# external dependencies
require 'serialport'
require 'pry'

# local dependencies
require 'physical/byte'
require 'physical/bytes'
require 'application/message'

require 'physical/channel'
require 'datalink/receiver'
require 'datalink/transmitter'
require 'listeners/global_listener'

require 'helpers'

# Container
class Walter
  include Observable
  include WalterTools

  PROC = 'Walter'.freeze

  def initialize
    # TODO: better argument handling to support multiple log files
    @channel = Channel.new(ARGV.shift)

    @receiver = Receiver.new(@channel.input_buffer)
    @transmitter = Transmitter.new(@channel.output_buffer)

    bus_handler = BusHandler.new(@transmitter)
    transmission_handler = TransmissionHandler.new(@transmitter.write_queue)

    @listener = GlobalListener.new(bus: bus_handler, transmission: transmission_handler)
    @channel.add_observer(@listener)
    @receiver.add_observer(@listener)
    # @application_layer.add_observer(@listener)

    add_observer(@listener)

    require 'bus_device'
    @bus_device = BusDevice.new
    @bus_device.add_observer(@listener)
  end

  def launch
    LOGGER.debug(PROC) { '#launch' }
    Thread.current[:name] = 'Walter (Main)'
    begin
      start
      # TODO: menu to facilitate common features...
      raise NotImplementedError, 'menu not implemented. fallback to CLI...'

      LOGGER.debug "Main Thread / Entering keep alive loop..."
      loop do
        news
        sleep 60
      end

      # TODO: menu to facilitate common features...
      # raise NotImplementedError, 'menu not implemented. fallback to CLI...'
    rescue NotImplementedError
      LOGGER.info 'fallback CLI'

      binding.pry

      LOGGER.info("Walter") { "Walter is closing!" }

      LOGGER.info("Walter") { "Publishing event: #{Event::EXIT}" }
      changed
      notify_observers(Event::EXIT, {reason: 'Debug exiting'})
      LOGGER.info("Walter") { "Subscribers updated! #{Event::EXIT}" }

      LOGGER.info("Walter") { "Turning stack off ⛔️" }
      stop
      LOGGER.info("Walter") { "Stack is off 👍" }

      LOGGER.info("Walter") { "See you anon ✌️" }
      return -1
    rescue Interrupt
      LOGGER.debug 'Interrupt signal caught.'
      binding.pry
      changed
      notify_observers(Event::EXIT, {reason: 'Interrupt!'})
      stop
      return 1
    end
  end

  def start
    LOGGER.debug(PROC) { '#start' }
    @channel.on
    @receiver.on
    @transmitter.on
  end

  def stop
    LOGGER.debug(PROC) { '#stop' }

    LOGGER.info(PROC) { 'Switching off Receiver...' }
    @receiver.off
    LOGGER.info(PROC) { 'Receiver is off! 👍' }

    LOGGER.info(PROC) { 'Switching off Channel...' }
    @channel.off
    LOGGER.info(PROC) { 'Channel is off! 👍' }
  end

  private

  end
end
