# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedRadio < AugmentedDevice
    include API::Media
    include API::RadioLED
    include Actions
    include Notifications

    PROC = 'AugmentedRadio'
  end
end
