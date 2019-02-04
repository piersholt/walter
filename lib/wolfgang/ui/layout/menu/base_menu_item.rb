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
          @label = label
          @action = action
          @properties = properties
        end

        def to_s
          label
        end
      end

      # Comment
      class CheckedItem < BaseMenuItem
        CHECKED_MASK = "%-13s"
        CHECKED_CHAR = 42.chr

        def initialize(checked:, label:, **base_menu_item_args)
          base_menu_item_args[:label] = checked_label(label, checked)
          super(base_menu_item_args)
          @checked = checked
        end

        def checked_label(label, checked)
          return label unless checked
          Kernel.format(CHECKED_MASK, label) << CHECKED_CHAR
        end
      end
    end
  end
end
