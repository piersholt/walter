# frozen_string_literal: true

# Comment
class DataLinkListener < BaseListener
  # name = self.class.name

  def initialize(interface_handler)
    @interface_handler = interface_handler
  end

  def name
    self.class.name
  end

  def update(action, properties = {})
    # LOGGER.unknown(name) { "#update(#{action}, #{properties})" }
    case action
    when BUS_OFFLINE
      bus_offline(action, properties)
    end
  rescue StandardError => e
    LOGGER.error(name) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
  end

  private

  def bus_offline(action, properties)
    # LOGGER.warn(name) { 'Bus Offline!' }
    @interface_handler.update(action, properties)
  end
end
