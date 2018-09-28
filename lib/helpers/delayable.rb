module Delayable
  DEFAULT_SLEEP_TIMER = 5

  attr_writer :sleep_time
  attr_accessor :sleep_enabled

  def delay
    return false unless sleep_enabled?
    sleep(sleep_time)
    true
  end

  def sleep_enabled?
    return true if @sleep_enabled.nil?
    @sleep_enabled
  end

  def sleep_time
    @sleep_time ||= DEFAULT_SLEEP_TIMER
  end
end
