# frozen_string_literal: true

require 'application/intents/actions'
require 'application/intents/intents'
require 'application/intents/messaging_bus'

class IntentListener
  include Singleton
  include Event
  include Actions
  include Intents

  attr_reader :handler

  PROC = 'IntentListener'

  def initialize(handler = IntentHandler.instance)
    @handler = handler
  end

  def update(action, properties)
    case action
    when EXIT
      handler.close(properties)
    end
  end

  def handle(action, properties)
    return false unless valid_action?(action)

    begin
      case action
      when SEEK
        handler.seek(properties)
      else
        LOGGER.warn(PROC) { "#{action} not handled?" }
      end
    rescue StandardError => e
      LOGGER.error(PROC) { e }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end
end
