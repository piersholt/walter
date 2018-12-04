# frozen_string_literal: true

DEFAULT_BUS = ZeroMQBus
# DEFAULT_BUS = MessagingBus

class IntentHandler
  include Singleton
  include Event
  include Actions
  include Intents

  attr_reader :bus

  def initialize(bus = DEFAULT_BUS)
    @bus = bus.new
  end

  def close(properties)
    LOGGER.info(PROC) { "Exit: Closing bus." }
    intent = Intent.new(action: :exit, variant: :interrupt, operation: :close)
    @bus.close(intent)
  end

  def seek(properties)
    return false if properties[:control] == BUTTON && properties[:state] == PRESS
    return scan(properties) if properties[:state] == HOLD || @is_scanning

    action = SEEK
    variant = properties[:variant]
    operation = EXECUTE

    # LOGGER.warn(PROC) { "#{action} / #{variant} / #{operation}" }
    intent = Intent.new(action: action, variant: variant, operation: operation)
    @bus.publish(intent)
  end

  def scan(properties)
    case properties[:state]
    when HOLD
      @is_scanning = true
      x = COMMENCE
    when RELEASE
      @is_scanning = false
      x = CONCLUDE
    end
    action = SCAN
    variant = properties[:variant]
    operation = x
    # LOGGER.warn(PROC) { "#{action} / #{variant} / #{operation}" }
    intent = Intent.new(action: action, variant: variant, operation: operation)
    @bus.publish(intent)
  end
end
