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

  class Intent
    attr_reader :action, :variant, :operation

    def initialize(action:, variant:, operation:)
      @action = action
      @variant = variant
      @operation = operation
    end

    def to_yaml
      { INTENT => { action: action, variant: variant, operation: operation }}.to_yaml
    end

    def to_json
      return ''
    end
  end
end
