# frozen_string_literal: true

module Wilhelm
  module SDK
    module UIKit
      module View
        # SDK::UIKit::View::BaseHeader
        class BaseHeader < Base
          attr_reader :fields, :title

          LAYOUT = 0x62
          TYPE = :default

          def initialize(values, title = nil)
            @fields = indexed_fields(values)
            @title = parse_title(title)
          end
          #
          # def initialize(values, title = nil)
          #   @fields = indexed_fields(values)
          #   @title = parse_title(title)
          # end

          def type
            self.class.const_get(:TYPE)
          end

          def indexed_items(dirty_indexes = [])
            return fields.to_h if dirty_indexes.empty?

            fields.to_h.keep_if do |key, _|
              dirty_indexes.include?(key + 1)
            end
          end

          def parse_title(value)
            return nil unless value
            BaseField.new(label: value.to_s)
          end

          def indexed_chars
            title_hash = [0, title.to_c]

            value_fields = fields.find_all { |f| f[1] }
            value_hash = value_fields.map do |field|
              index = field[0] + 1
              field_object = field[1]
              [index, field_object.to_c]
            end

            all_fields = value_hash << title_hash

            # title_hash = { 0 => title.to_c }
            # all_fields = title_hash.merge(value_hash.to_h)

            logger.debug(self.class.name) { "#indexed_chars => #{all_fields.to_h}" }

            all_fields.to_h
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
end
