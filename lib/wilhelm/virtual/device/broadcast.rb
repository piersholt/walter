# frozen_string_literal: true

# Comment
module Wilhelm
  module Virtual
    class BroadcastDevice < Device
      PROC = 'BroadcastDevice'

      def type
        :broadcast
      end
    end
  end
end
