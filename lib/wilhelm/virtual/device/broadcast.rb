# frozen_string_literal: true

# Comment
class Wilhelm::Virtual
  class BroadcastDevice < Device
    PROC = 'BroadcastDevice'

    def type
      :broadcast
    end
  end
end
