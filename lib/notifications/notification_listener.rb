# frozen_string_literal: true

require 'notifications/subscriber'

# Comment
class NotificationListener
  attr_accessor :handler, :thread

  def initialize(subscriber)
    @subscriber = subscriber

  end

  def setup
    Subscriber.pi
    Subscriber.subscribe(:device)
    Subscriber.subscribe(:media)
  end

  def delegate(notification)
    handler.oi(notification)
  end

  def listen
    @thread = Thread.new do
      begin
        setup
        LOGGER.warn('Notification') { 'Thread start!' }
        i = 1
        loop do
          LOGGER.warn('Notification') { "#{i}. Wait" }
          notification = Subscriber.recv
          LOGGER.warn('Notification') { "#{i}. #{notification}" }
          delegate(notification)
          i += 1
        end
        LOGGER.warn('Notification') { 'Thread end!' }
      rescue StandardError => e
        LOGGER.error(self.class) { e }
        e.backtrace.each do |line|
          LOGGER.error(self.class) { line }
        end
      end
    end
  end
end

# Comment
class NotificationHandler
  def initialize(bus)
    @bus = bus
  end

  def oi(payload)
    LOGGER.info(self.class) { payload }
    object = YAML.load(payload)
    LOGGER.info(self.class) { object.class }
    LOGGER.info(self.class) { object.keys }
    LOGGER.info(self.class) { object.values }

    case object[:type]
    when :device
      device(object)
    when :media
      media(object)
    end
  end

  def device(object)
    case object[:name]
    when :device_connecting
      @bus.tel.bluetooth_connecting
    when :device_connected
      @bus.tel.bluetooth_connected
    when :device_disconnecting
      @bus.tel.bluetooth_disconnecting
    when :device_disconnected
      @bus.tel.bluetooth_disconnected
    end
  end

  def media(object)
    case object[:name]
    when :track_change
      track = object[:options][:delta]['Track']
      LOGGER.fatal(self.class) { track }
      @bus.rad.track_change(track)
    end
  end
end

# Comment
class Notifications
  include Singleton

  attr_reader :listener, :handler

  def self.start(bus)
    instance.start(bus)
  end

  def start(bus)
    return false if started?
    @listener = NotificationListener.new(Subscriber)
    @handler = NotificationHandler.new(bus)
    listener.handler = handler
    listener.listen
  end

  def started
    @started = true
  end

  def started?
    @started ? true : false
  end
end
