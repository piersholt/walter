# core dependencies
require 'observer'
require 'thread'

# external dependencies
require 'serialport'
require 'pry'

# local dependencies
require 'byte'
require 'bytes'
require 'frame'
require 'message'

require 'channel'
require 'new_receiver'
require 'application_layer'
require 'listeners/global_listener'

# Container
class Walter
  include Observable

  attr_reader :threads

  def initialize
    # TODO: better argument handling to support multiple log files
    @channel = Channel.new(ARGV.shift)

    @receiver = NewReceiver.new(@channel.input_buffer)
    # @transmitter = Transmitter.new(@channel.output_buffer)

    @application_layer = ApplicationLayer.new

    @listener = GlobalListener.new(@application_layer)
    @channel.add_observer(@listener)
    @receiver.add_observer(@listener)
    # @application_layer.add_observer(@listener)

    # @threads = ThreadGroup.new
    add_observer(@listener)
  end

  def shutup!
    DisplayHandler.i.shutup!
  end

  def messages
    SessionHandler.i.messages
  end

  def news
    puts "THREADS:"
    Thread.list.each_with_index do |t, i|
      LOGGER.info("#{i}. #{t[:name]}") { "#{t.status} (#{t.group.inspect})" }
    end
    true
  end

  def launch
    LOGGER.debug "#{self.class}#launch"
    Thread.current[:name] = 'Walter (Main)'
    begin
      # TODO: menu to facilitate common features...
      raise NotImplementedError, 'menu not implemented. fallback to CLI...'

      LOGGER.debug "Main Thread / Entering keep alive loop..."
      loop do
        Thread.list.each { |t| LOGGER.unknown("#{t[:name]} / #{t.status}") }
        sleep 10
      end

      # TODO: menu to facilitate common features...
      # raise NotImplementedError, 'menu not implemented. fallback to CLI...'
    rescue NotImplementedError
      LOGGER.info 'fallback CLI'
      start
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
