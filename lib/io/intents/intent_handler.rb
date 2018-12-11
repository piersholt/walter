# frozen_string_literal: true

# Comment
class IntentHandler
  include Messaging::Constants
  include Singleton
  include Event
  include Actions
  include Intents

  def initialize
    # ready
  end

  def close(properties)
    LOGGER.info(PROC) { 'Closing bus.' }
    n = Messaging::Notification
        .new(topic: :system, name: :publish,
             properties: { status: :end, event: properties })
    Publisher.send(n.topic, n.to_yaml)
    Publisher.close
  end
end
