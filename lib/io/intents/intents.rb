# frozen_string_literal: true

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

require 'io/intents/intent_handler'
require 'io/intents/intent_listener'
