# frozen_string_literal: true

# Comment
class NotificationHandler
  def initialize(bus)
    @bus = bus
  end

  def oi(message)
    LOGGER.info(self.class) { message }
    # object = YAML.load(message)
    # LOGGER.info(self.class) { object.class }
    # LOGGER.info(self.class) { object.keys }
    # LOGGER.info(self.class) { object.values }
    notification = Messaging::Serialized.new(message).parse
    LOGGER.info(self.class) { "Deserialized: #{notification}" }

    case notification.topic
    when :device
      device(notification)
    when :target
      # media(notification)
    when :player
      player(notification)
    end
  rescue StandardError => e
    LOGGER.error(PROC) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
    binding.pry
  end

  def device(notification)
    case notification.name
    when :device_connecting
      @bus.tel.bluetooth_connecting
    when :device_connected
      @bus.tel.bluetooth_connected
    when :device_disconnecting
      @bus.tel.bluetooth_disconnecting
    when :device_disconnected
      @bus.tel.bluetooth_disconnected
    end
  rescue StandardError => e
    LOGGER.error(PROC) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
    binding.pry
  end

  def player(notification)
    case notification.name
    when :track_change
      track = notification.properties
      LOGGER.fatal(self.class) { track }
      @bus.rad.track_change(track)
    end
  rescue StandardError => e
    LOGGER.error(PROC) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
    binding.pry
  end
end
