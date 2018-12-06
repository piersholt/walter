# frozen_string_literal: true

# Comment
class NotificationHandler
  def initialize(bus)
    @bus = bus
  end

  def oi(message)
    LOGGER.info(self.class) { message }
    object = YAML.load(message)
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
