# frozen_string_literal: true

module Wolfgang
  class UserInterface
    module View
      # Comment
      class BaseMenuItem
        DEFAULT_ACTION = :no_action
        attr_reader :id, :label, :action, :arguments

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
          label.encode(Encoding::ASCII_8BIT, Encoding::UTF_8, {undef: :replace})[0,40]
        rescue StandardError => e
          LogActually.ui.error(self.class.name) { e }
          e.backtrace.each { |line| LogActually.ui.error(self.class.name) { line } }
        end
      end
    end
  end
end
