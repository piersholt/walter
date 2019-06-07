# frozen_string_literal: true

# Comment
module NotificationsRelay
  # include InterfaceConstants

  def relay(notification)
    Publisher.send!(notification)
  end
end
