# frozen_string_literal: true

# Comment
class DisplayListener < BaseListener
  def initialize(display_handler = DisplayHandler.instance)
    @display_handler = display_handler
  end

  def name
    self.class.name
  end

  def update(action, properties = {})
    # LOGGER.unknown(name) { "#update(#{action}, #{properties})" }
    case action
    when MESSAGE_RECEIVED
      message_received(action, properties)
    when EXIT
      exit(action, properties)
    end
  rescue StandardError => e
    LOGGER.error(name) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
  end

  private

  def message_received(action, properties)
    @display_handler.update(action, properties)
  end

  def exit(action, properties)
    LOGGER.debug(PROC) { "Delegate: #{@display_handler.class}" }
    @display_handler.update(action, properties)
    LOGGER.debug(PROC) { "Delegate: #{@display_handler.class} complete!" }
  end
end
