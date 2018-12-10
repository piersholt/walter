# frozen_string_literal: true

class IntentHandler
  include Messaging::Constants
  include Singleton
  include Event
  include Actions
  include Intents

  def initialize
    # Publisher = bus
    Publisher.ready
  end

  def ready
    LOGGER.info(PROC) { 'Ready bus.' }
    n = Messaging::Notification
        .new(topic: :walter, name: :publish,
             properties: { status: :start })
    Publisher.send(n.topic, n.to_yaml)
  end

  def close(properties)
    LOGGER.info(PROC) { "Exit: Closing bus." }
    @bus.close
  end

  def seek(properties)
    return false if properties[:control] == BUTTON && properties[:state] == PRESS
    return scan(properties) if properties[:state] == HOLD || @is_scanning

    action = SEEK
    variant = properties[:variant]
    operation = EXECUTE

    name = "#{action}_#{variant}_#{operation}"
    action = Messaging::Action.new(topic: MEDIA, name: name)
    @bus.send(action.topic, action.to_yaml)
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

    name = "#{action}_#{variant}_#{operation}"
    action = Messaging::Action.new(topic: MEDIA, name: name)
    @bus.send(action.topic, action.to_yaml)
  end
end
