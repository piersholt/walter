# frozen_string_literal: true

module Wilhelm::SDK
  class UserInterface
    module View
      # Comment
      class CheckedItem < BaseMenuItem
        CHECKED_MASK = "%-13s"
        CHECKED_CHAR = 42.chr

        def initialize(checked:, label:, **base_menu_item_args)
          base_menu_item_args[:label] = checked_label(label, checked)
          super(base_menu_item_args)
          @checked = checked
        end

        def checked_label(label, checked, checked_char = CHECKED_CHAR)
          return label unless checked
          Kernel.format(CHECKED_MASK, label) << checked_char
        end
      end
    end
  end
end
