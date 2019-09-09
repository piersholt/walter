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
        LAYOUT_CLASS_MAP = {
          0x60 => Menu::Basic.new,
          0x61 => Menu::Titled.new,
          0x62 => Header::Digital.new,
          0x63 => Menu::Static.new
        }.freeze

        SYMBOL_TO_ID_MAP = {
          basic: 0x60,
          titled: 0x61,
          digital: 0x62,
          static: 0x63
        }.freeze

        def validate_layout(layout)
          return true if SYMBOL_TO_ID_MAP.key?(layout)
          return true if LAYOUT_CLASS_MAP.key?(layout)
          raise(ArgumentError, "Invalid layout! #{layout}") unless objects.key?(layout)
        end

        def pending!(layout, data, flush: false)
          validate_layout(layout)
          layout = SYMBOL_TO_ID_MAP[layout] if layout.is_a?(Symbol)
          # LOGGER.debug(self.class) { "#pending! (#{Thread.current})" }
          objects[layout]&.clear if flush
          objects[layout]&.pending!(data)
        end

        def write!(layout, data, flush: false)
          validate_layout(layout)
          layout = SYMBOL_TO_ID_MAP[layout] if layout.is_a?(Symbol)
          # LOGGER.debug(self.class) { "#write! (#{Thread.current})" }
          objects[layout]&.clear if flush
          objects[layout]&.write!(data)
        end

        def dirty_ids(layout)
          validate_layout(layout)
          layout = SYMBOL_TO_ID_MAP[layout] if layout.is_a?(Symbol)
          # LOGGER.debug(self.class) { "#dirty_ids (#{Thread.current})" }
          objects[layout]&.dirty_ids
        end

        def expired?(layout)
          validate_layout(layout)
          # LOGGER.debug(self.class) { "#expired? (#{Thread.current})" }
          layout = SYMBOL_TO_ID_MAP[layout] if layout.is_a?(Symbol)
          objects[layout]&.expired?
        end

        def objects
          @objects ||= create_objects
        end

        def create_objects
          LOGGER.debug(self.class) { "#create_objects (#{Thread.current})" }
          {
            0x60 => Menu::Basic.new,
            0x61 => Menu::Titled.new,
            0x62 => Header::Digital.new,
            0x63 => Menu::Static.new
          }
        end

        # 0x60
        def basic
          objects[0x60]
        end

        # 0x61
        def titled
          objects[0x61]
        end

        # 0x62
        def digital
          objects[0x62]
        end

        # 0x63
        def static
          objects[0x63]
        end

        def by_layout_id(id)
          return false unless objects.key?(id)
        end

        alias layout by_layout_id
      end
    end
  end
end
