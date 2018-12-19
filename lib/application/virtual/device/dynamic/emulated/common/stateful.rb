module Stateful
  def state
    @state ||= default_state
  end

  private

  def state!(delta)
    state.merge!(delta)
  end

  def start_timer
    @t0 = Time.now
  end

  def elapased_time
    t1 = Time.now
    t1 - @t0
  end

  def default_state
    raise StandardError, 'Inheriting class has not implemented default state!'
  end
end
