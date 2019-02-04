# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      # Comment
      class BaseHeader
        include Observable

        attr_reader :fields, :title

        LAYOUT = 0x62

        def initialize(values, title = nil)
          @fields = indexed_fields(values)
          @title = parse_title(title)
        end

        def logger
          LogActually.wolfgang
        end

        def layout
          self.class.const_get(:LAYOUT)
        end

        def type
          self.class.const_get(:TYPE)
        end

        def fields_with_index
          fields.to_h
        end

        def parse_title(value)
          return nil unless value
          BaseField.new(label: value)
        end

        def indexed_fields(values)
          values.map.with_index do |value, index|
            # property_value = device.public_send(property)
            field_view = value ? BaseField.new(label: value) : nil
            [index, field_view]
          end
        end
      end
    end
  end
end
