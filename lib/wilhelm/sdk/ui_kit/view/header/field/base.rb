# frozen_string_literal: true

module Wilhelm
  module SDK
    module UIKit
      module View
        # SDK::UIKit::View::BaseField
        class BaseField
          attr_reader :id, :label, :arguments
          NO_PROPERTIES = {}.freeze

          def initialize(id: false, label:, properties: NO_PROPERTIES.dup)
            @id = id
            @label = label
            @properties = properties
          end

          def to_s
            label
          end

          def to_c
            label.encode(Encoding::ASCII_8BIT).bytes
          end
        end
      end
    end
  end
end
