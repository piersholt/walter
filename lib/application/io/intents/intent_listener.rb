# frozen_string_literal: true

# Comment
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

    case action
    when false
      false
    else
      LOGGER.warn(PROC) { "#{action} not handled?" }
    end
  rescue StandardError => e
    LOGGER.error(PROC) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
  end
end
