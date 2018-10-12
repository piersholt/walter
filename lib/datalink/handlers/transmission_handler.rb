class TransmissionHandler < BaseHandler
  include Event

  attr_reader :queue

  def initialize(write_queue)
    @queue = write_queue
  end

  def inspect
    str_buffer = "<Transmissionhandler>"
  end

  def update(action, properties)
    case action
    when FRAME_SENT
      frame = fetch(properties, :frame)
      queue_frame(frame)
    end
  end

  private

  def queue_frame(frame)
    @queue << frame
  end
end
