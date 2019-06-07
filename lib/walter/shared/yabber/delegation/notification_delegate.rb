# frozen_string_literal: true

# Comment
module NotificationDelegate
  include NotificationDelegateVaidation
  attr_accessor :successor

  def handle(notification)
    if responsible?(notification)
      LOGGER.debug(self.class) { "I am responsible for #{notification.name}!" }
      take_responsibility(notification)
    else
      LOGGER.debug(self.class) { "Not me! Forwarding: #{notification.name}" }
      forward(notification)
    end
  end

  def logger
    LogActually.notifications
    raise(StandardError, 'do not use NotificationDelegate logger as is shared...')
  end

  def forward(notification)
    raise(IfYouWantSomethingDone, "No one to handle: #{notification}") unless successor
    successor.handle(notification)
  end

  def responsible?(notification)
    result = notification.topic == responsibility
    logger.debug(self.class) { "#{notification.topic} == #{responsibility} => #{result}" }
    result
  end

  def not_handled(command)
    # logger.info(self.class) { "#{command.name}: Currently not implemented." }
    logger.warn(self.class) { "#{command.name}: Currently not implemented. (#{command.properties})" }
  end
end
