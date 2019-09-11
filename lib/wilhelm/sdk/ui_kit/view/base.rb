# frozen_string_literal: true

module Wilhelm
  module SDK
    module UIKit
      module View
        # SDK::UIKit::View::BaseMenu
        class Base
          include Observable

          class_variable_set(:@@subclasses, [])

          def self.inherited(subclass)
            # puts "New subclass: #{subclass}"
            class_variable_get(:@@subclasses) << subclass
          end

          def self.subclasses
            class_variable_get(:@@subclasses)
          end

          def logger
            LOGGER
          end

          def layout
            self.class.const_get(:LAYOUT)
          end

          def moi
            self.class.name
          end
        end
      end
    end
  end
end
