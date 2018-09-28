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
require 'datalink/new_receiver'
require 'datalink/transmitter'
require 'application/application_layer'
require 'listeners/global_listener'

# Container
class Walter
  include Observable

  attr_reader :threads

  def initialize
    # TODO: better argument handling to support multiple log files
    @channel = Channel.new(ARGV.shift)

    @receiver = NewReceiver.new(@channel.input_buffer)
    @transmitter = Transmitter.new(@channel.output_buffer)

    bus_handler = BusHandler.new(@transmitter)
    transmission_handler = TransmissionHandler.new(@transmitter.write_queue)

    @listener = GlobalListener.new(bus: bus_handler, transmission: transmission_handler)
    @channel.add_observer(@listener)
    @receiver.add_observer(@listener)
    # @application_layer.add_observer(@listener)

    # @threads = ThreadGroup.new
    add_observer(@listener)

    require 'bus_device'
    @bus_device = BusDevice.new
    @bus_device.add_observer(@listener)
  end

  def shutup!
    DisplayHandler.i.shutup!
  end

  def messages
    SessionHandler.i.messages
  end

  def rate(seconds)
    @channel.sleep_time = seconds
  end

  def sleep
    @channel.sleep_enabled = true
  end

  def no_sleep
    @channel.sleep_enabled = false
  end

  def news
    puts "THREADS:"
    Thread.list.each_with_index do |t, i|
      LOGGER.info("#{t[:name]}") { "#{t.status} (#{t.group.inspect})" }
    end
    true
  end

  def fuck_yeah!
    @bus_device.update(chars: "fuck yeah".bytes, ike: :set_ike, gfx: :radio_set)
  end

  def key
    @bus_device.state(key: :key_6, status: 0x04)
  end

  def launch
    LOGGER.debug "#{self.class}#launch"
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
    LOGGER.debug("#{self.class}#start")
    # @threads.add(start)
    @channel.on
    @receiver.on
    @transmitter.on
  end

  def stop
    LOGGER.debug "#{self.class}#stop"

    LOGGER.info("Walter") { "Switching off Receiver..." }
    @receiver.off
    LOGGER.info("Walter") { "Receiver is off! 👍" }

    LOGGER.info("Walter") { "Switching off Channel..." }
    @channel.off
    LOGGER.info("Walter") { "Channel is off! 👍" }
  end

  private

  # def thead_app
  #   LOGGER.debug("#{self.class}#thread_populate_input_buffer")
  #
  #   Thread.new do
  #     LOGGER.info("Starting @ #{Time.now}")
  #
  #     begin
  #       @channel.on
  #       @receiver.on
  #
  #
  #     rescue Interrupt
  #       LOGGER.debug 'Break signal detected.'
  #       # changed
  #       # notify_observers(Event::EXIT)
  #       LOGGER.info 'Quiting...'
  #
  #
  #       LOGGER.debug "Closing threads..."
  #       @receiver.off
  #       @channel.off
  #
  #
  #       # TODO: decouple register via event
  #       Device.close
  #       Command.close
  #
  #       binding.pry
  #       return 1
  #     end
  #   end
  #
  #   LOGGER.warn 'App#start returning!'
  #   1
  # end

  def close_threads
    LOGGER.debug "#{self.class}#close_threads"
    threads = @threads.list
    threads.each_with_index do |t, i|
      LOGGER.debug "Thread ##{i+1} / #{t.status}"
      # LOGGER.debug "result = #{t.exit}"
      t.exit
      LOGGER.debug "Thread ##{i+1} / #{t.status}"
    end
  end
end
