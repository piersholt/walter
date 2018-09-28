class TransmissionHandler
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
      queue_frame(properties[:frame])
    end
  end

  private

  def queue_frame(frame)
    @queue << frame
  end
end
