# frozen_string_literal: true

module Wilhelm
  module Helpers
    # Helpers::Object
    module Object
      ID_ENCODED_MULTIPLIER = 2
      ID_ENCODED_MASK = '%#.14x'

      def human_id(object)
        "<#{object.class}:#{id_encoded(object)}>"
      end

      alias hid human_id

      def id_encoded(object)
        Kernel.format(ID_ENCODED_MASK, object.object_id * ID_ENCODED_MULTIPLIER)
      end
    end
  end
end
