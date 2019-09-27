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
        LAYOUT_60 = 0x60
        LAYOUT_61 = 0x61
        LAYOUT_62 = 0x62
        LAYOUT_63 = 0x63

        LAYOUT_CLASS_MAP = {
          LAYOUT_60 => Menu::Basic,
          LAYOUT_61 => Menu::Titled,
          LAYOUT_62 => Header::Digital,
          LAYOUT_63 => Menu::Static
        }.freeze

        SYMBOL_TO_ID_MAP = {
          basic: LAYOUT_60,
          titled: LAYOUT_61,
          digital: LAYOUT_62,
          static: LAYOUT_63
        }.freeze

        def pending!(layout, data, flush: false)
          id = sym_to_id(layout)
          objects[id]&.clear if flush
          objects[id]&.pending!(data)
        end

        def write!(layout, data, flush: false)
          id = sym_to_id(layout)
          objects[id]&.clear if flush
          objects[id]&.write!(data)
        end

        def reset!
          @objects = create_objects
        end

        def dirty_ids(layout)
          id = sym_to_id(layout)
          objects[id]&.dirty_ids
        end

        def expired?(layout)
          id = sym_to_id(layout)
          objects[id]&.expired?
        end

        # 0x60
        def basic
          objects[LAYOUT_60]
        end

        # 0x61
        def titled
          objects[LAYOUT_61]
        end

        # 0x62
        def digital
          objects[LAYOUT_62]
        end

        # 0x63
        def static
          objects[LAYOUT_63]
        end

        private

        def objects
          @objects ||= create_objects
        end

        def create_objects
          LOGGER.debug(self.class) { "#create_objects (#{Thread.current})" }
          {
            LAYOUT_60 => LAYOUT_CLASS_MAP[LAYOUT_60]&.new,
            LAYOUT_61 => LAYOUT_CLASS_MAP[LAYOUT_61]&.new,
            LAYOUT_62 => LAYOUT_CLASS_MAP[LAYOUT_62]&.new,
            LAYOUT_63 => LAYOUT_CLASS_MAP[LAYOUT_63]&.new
          }
        end

        def sym_to_id(layout)
          validate_layout(layout)
          return layout unless layout.is_a?(Symbol)
          SYMBOL_TO_ID_MAP[layout]
        end

        def validate_layout(layout)
          return true if SYMBOL_TO_ID_MAP.key?(layout)
          return true if LAYOUT_CLASS_MAP.key?(layout)
          return true if objects.key?(layout)
          raise(ArgumentError, "Invalid layout! #{layout}")
        end

        def by_layout_id(id)
          return false unless objects.key?(id)
        end

        alias layout by_layout_id
      end
    end
  end
end
