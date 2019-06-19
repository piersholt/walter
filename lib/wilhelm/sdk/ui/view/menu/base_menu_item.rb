# frozen_string_literal: true

module Wilhelm
  module SDK
    class UserInterface
      module View
        # Comment
        class BaseMenuItem
          DEFAULT_ACTION = :no_action
          attr_reader :id, :label, :action, :properties

          def initialize(id: false, label:, action: DEFAULT_ACTION, properties: {})
            @id = id
            @label = encode(label)
            @action = action
            @properties = properties
          end

          def to_s
            label
          end

          def to_c
            label.bytes
          end

          def encode(label)
            # Yeah, so sue me...
            case label.encoding
            when Encoding::ASCII_8BIT
              label[0,40]
            when Encoding::UTF_8
              label.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, {undef: :replace})[0,40]
            else
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
