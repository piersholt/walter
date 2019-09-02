# frozen_string_literal: true

require_relative 'cache/value'
require_relative 'cache/base'
require_relative 'cache/header/digital'
require_relative 'cache/menu/static'
require_relative 'cache/menu/titled'
require_relative 'cache/menu/basic'

module Wilhelm
  module API
    class Display
      # API::Display::Cache
      class Cache
        def header
          @header ||= { digital: Header::Digital.new }
        end

        def menu
          @menu ||= {
            basic: Menu::Basic.new,
            titled: Menu::Titled.new,
            static: Menu::Static.new
          }
        end

        # 0x62
        def digital
          header[:digital]
        end

        # 0x60
        def basic
          menu[:basic]
        end

        # 0x61
        def titled
          menu[:titled]
        end

        # 0x63
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
