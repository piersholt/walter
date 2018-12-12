# frozen_string_literal: true

# Comment
class FrameListener < BaseListener
  def initialize(frame_handler)
    @frame_handler = frame_handler
  end

  def name
    self.class.name
  end

  def update(action, properties = {})
    LOGGER.unknown(name) { "#update(#{action}, #{properties})" }
    case action
    when MESSAGE_SENT
      message_sent(action, properties)
    end
  rescue StandardError => e
    LOGGER.error(name) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
  end

  private

  def message_sent(action, properties)
    @frame_handler.update(action, properties)
  end

  def frame_sent(action, properties)
    @frame_handler.update(action, properties)
  end

  def frame_received(action, properties)
    @frame_handler.update(action, properties)
  end
end
