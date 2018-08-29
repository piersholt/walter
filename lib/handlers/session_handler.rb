require 'singleton'
require 'messages'

class SessionHandler
  include Singleton
  include Event

  METRICS = [BYTE_RECEIVED, FRAME_VALIDATED, FRAME_FAILED, MESSAGE_RECEIVED]

  attr_reader :messages, :stats, :frames

  def self.i
    instance
  end

  def initialize
    @messages = Messages.new
    @frames = []
  end

  def inspect
    str_buffer = "<SessionHandler>"
  end

  def add_message(message)
    @messages << message
  end

  def add_frame(frame)
    @frames << frame
  end

  def update(action, properties)
    case action
    when BYTE_RECEIVED
      update_stats(action)
    when FRAME_FAILED
      update_stats(action)
    when FRAME_VALIDATED
      update_stats(action)
      add_frame(properties[:frame])
    when MESSAGE_RECEIVED
      update_stats(action)
      add_message(properties[:message])
    end
  end

  def stats
    @stats ||= METRICS.map do |metric|
      [metric, 0]
    end.to_h
  end

  private

  def update_stats(metric)
    stats[metric] += 1
  end
end
