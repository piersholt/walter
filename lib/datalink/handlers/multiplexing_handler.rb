require 'singleton'
require 'datalink/frame/frame_builder'

class MultiplexingHandler
  include Observable
  include Singleton
  include Event

  def self.i
    instance
  end

  def inspect
    '<MultiplexingHandler?'
  end

  def update(action, properties)
    case action
    when MESSAGE_SENT
      message = properties[:message]
      frame = multiplex(message)

      changed
      notify_observers(FRAME_SENT, frame: frame)
    end
  end

  private

  # @return Frame
  def multiplex(message)
    frame_builder = FrameBuilder.new

    frame_builder.from = message.from.d
    frame_builder.to = message.to.d
    frame_builder.command = message.command

    frame = frame_builder.result
    LOGGER.warn('MultiplexingHandler') { "Frame build: #{frame}" }
    frame
  end
end
