# frozen_string_literal: true

module Actions
  def self.included(mod)
    raise ScriptError, "#{mod} cannot use Actions due to deprececation."
  end

  # ACTION
  SEEK = :seek
  SCAN = :scan

  # VARIANT
  NEXT = :next
  PREVIOUS = :previous

  # CONTROLS (AND STATES)
  BUTTON = :button

  PRESS = :press
  HOLD = :hold
  RELEASE = :release

  def valid_action?(action)
    [SEEK].one? { |i| i == action }
  end
end
