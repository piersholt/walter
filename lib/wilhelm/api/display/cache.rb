# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # API::Display::Cache
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

          def by_layout_id(id)
            case id
            when 0x60
              basic
            when 0x61
              titled
            when 0x63
              static
            end
          end

          alias layout by_layout_id
        end
      end
    end
end
