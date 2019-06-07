# frozen_string_literal: true

# Comment
class Virtual
  class BroadcastDevice < Device
    PROC = 'BroadcastDevice'

    def type
      :broadcast
    end
  end
end
