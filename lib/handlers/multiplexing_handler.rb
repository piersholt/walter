require 'singleton'
require 'frame_builder'

class MultiplexingHandler
  include Observable
  include Singleton
  include Event

  def self.i
    instance
  end

  # def initialize
  #   @frame_builder = FrameBuilder.new
  # end

  def inspect
    '<MultiplexingHandler?'
  end

  def update(action, properties)
    case action
    when MESSAGE_SENT
      @frame_builder = FrameBuilder.new
      frame = process_message(properties[:message])
      changed
      notify_observers(FRAME_SENT, frame: frame)
    end
  end

  private

  # @return Frame
  def process_message(message)
    @frame_builder.from = message.from.d
    @frame_builder.to = message.to.d
    @frame_builder.command = message.command
    frame = @frame_builder.result
    LOGGER.warn('MultiplexingHandler') { "Frame build: #{frame}" }
    frame
  end
end
