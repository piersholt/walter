# frozen_string_literal: true

require 'application/intents/intent_handler'
require 'application/intents/intent_listener'

module Intents
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
