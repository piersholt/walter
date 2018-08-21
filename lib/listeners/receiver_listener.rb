# documentation
class ReceiverListener
  BYTE_RECEIVED = :read_byte
  FRAME_VALIDATED = :frame_validated
  FRAME_FAILED = :frame_failed

  EVENTS = [BYTE_RECEIVED, FRAME_VALIDATED, FRAME_FAILED].freeze

  def initialize
    @stats = { BYTE_RECEIVED => 0, bytes_dropped: 0, FRAME_VALIDATED => 0, FRAME_FAILED => 0 }
  end

  def update(action, properties)
    raise ::ArgumentError, 'unrecognised action' unless EVENTS.one? { |e| e == action }

    case action
    when BYTE_RECEIVED
      update_stats(BYTE_RECEIVED)
      debug(BYTE_RECEIVED, properties)
    when FRAME_VALIDATED
      update_stats(FRAME_VALIDATED)
    end
  end

  private

  # HANDLERS

  def update_stats(metric)
    @stats[metric] += 1
  end

  def debug(action, properties)
    # LOGGER.debug "Channel / #{action}: #{properties[:read_byte]}, POS: #{properties[:pos]}"
  end
end
