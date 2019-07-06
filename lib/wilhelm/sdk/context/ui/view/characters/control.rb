# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module View
          module Characters
            # Characters::Pixels
            class ControlCharacters < UIKit::View::StaticMenu
              include UIKit::View
              CONTROL = 'Characters::Control'

              def initialize(control_model)
                @attributes = parse_model(control_model)
              end

              def menu_items
                @attributes
              end

              # @override View::BaseMenu::input_left
              def input_left(*)
                changed
                notify_observers(:control_left)
              end

              # @override View::BaseMenu::input_right
              def input_right(*)
                changed
                notify_observers(:control_right)
              end

              # @override View::BaseMenu::input_confirm
              def input_confirm(state:)
                LOGGER.debug(self.class.name) { "#input_confirm(#{state})" }
                case state
                when :press
                  return false
                when :hold
                  return false
                when :release
                  return false
                end
              end

              def parse_model(control_model)
                control_model.page.map do |index, character|
                  LOGGER.unknown(CONTROL) { "index => #{index}" }
                  LOGGER.unknown(CONTROL) { "character => #{character}" }
                  label = character.map(&:chr).join
                  LOGGER.unknown(CONTROL) { "label => #{label}" }
                  [index, BaseMenuItem.new(label: label)]
                end
              end
            end
          end
        end
      end
    end
  end
end
