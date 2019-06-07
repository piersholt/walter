# frozen_string_literal: false

# All mehods that are expected to be overriden by NotificationDelegate
module NotificationDelegateVaidation
  include DelegateValidation

  def take_responsibility(___ = nil)
    raise(NaughtyHandler, self.class.name)
  end
end
