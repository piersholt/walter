# frozen_string_literal: true

module Wilhelm
  module SDK
    module UIKit
      module View
        # Comment
        class BaseMenuItem
          DEFAULT_ACTION = :no_action
          attr_reader :id, :label, :action, :properties

          DEFAULT_TRUNCATE = true

          def initialize(id: false, label:, action: DEFAULT_ACTION, truncate: DEFAULT_TRUNCATE, properties: {})
            @id = id
            @label = encode(label, truncate)
            @action = action
            @properties = properties
          end

          def to_s
            label
          end

          def to_c
            label.bytes
          end

          def encode(label, truncate)
            # Yeah, so sue me...
            case label.encoding
            when Encoding::ASCII_8BIT
              return label unless truncate
              label[0,40]
            when Encoding::UTF_8
              buffer = label.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, {undef: :replace})
              return buffer unless truncate
              buffer[0,40]
            else
              return label unless truncate
              label[0,40]
            end
          rescue StandardError => e
            LOGGER.error(self.class.name) { e }
            e.backtrace.each { |line| LOGGER.error(self.class.name) { line } }
          end
        end
      end
    end
  end
end
