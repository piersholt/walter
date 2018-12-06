# frozen_string_literal: true

# Comment
class Virtual
  class BroadcastDevice < Device
    PROC = 'BroadcastDevice'.freeze

    def type
      :broadcast
    end
  end
end
