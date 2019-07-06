# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module View
          module Encoding
            # Characters::Pixels
            class Weight < UIKit::View::StaticMenu
              include UIKit::View
              WEIGHT = 'Characters::Weight'

              def initialize(weight_model)
                @attributes = parse_model(weight_model)
              end

              def menu_items
                @attributes
              end

              # @override View::BaseMenu::input_left
              def input_left(*)
                changed
                notify_observers(:weight_less)
              end

              # @override View::BaseMenu::input_right
              def input_right(*)
                changed
                notify_observers(:weight_more)
              end

              # @override View::BaseMenu::input_confirm
              def input_confirm(state:)
                LOGGER.debug(self.class.name) { "#input_confirm(#{state})" }
                case state
                when :press
                  changed
                  notify_observers(:weight_right)
                when :hold
                  return false
                when :release
                  return false
                end
              end

              def parse_model(weight_model)
                weight_model.page.map.with_index do |character, index|

                  label_buffer = Array.new(weight_model.width) do |_|
                    character[:ordinal].chr
                  end

                  label_buffer = label_buffer.join

                  [index, BaseMenuItem.new(label: label_buffer)]
                end
              end
            end
          end
        end
      end
    end
  end
end
