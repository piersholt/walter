# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # Comment
      class Cache
        def header
          @header ||= { digital: Digital.new }
        end

        def menu
          @menu ||= { basic: Basic.new,
            titled: Titled.new,
            static: Static.new }
          end

          def digital
            header[:digital]
          end

          def basic
            menu[:basic]
          end

          def titled
            menu[:titled]
          end

          def static
            menu[:static]
          end
        end
      end
    end
end
