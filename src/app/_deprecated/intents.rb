# frozen_string_literal: true

module Intents
  def self.included(mod)
    raise ScriptError, "#{mod} cannot use #{self} due to deprececation."
  end
  # CHANNEL
  INTENT = :intent

  # ACTION
  SEEK = :seek
  SCAN = :scan

  # VARIANT
  NEXT = :next
  PREVIOUS = :previous

  # OPERATION
  EXECUTE = :execute
  COMMENCE = :commence
  CONCLUDE = :conclude
end
