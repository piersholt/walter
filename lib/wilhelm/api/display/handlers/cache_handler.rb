# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # API::Display::CacheHandler
      module CacheHandler
        NAME = 'CacheHandler'

        def header_cache(layout:, index:, chars:)
          logger.debug(NAME) { "#header_cache(#{layout}, #{index}, #{chars})" }
          cache.write!(layout, index => chars)
        end

        def header_write(layout:, index:, chars:)
          logger.debug(NAME) { "#header_write(#{layout}, #{index}, #{chars})" }
          cache.write!(layout, index => chars)
        end

        def menu_cache(layout:, index:, chars:)
          logger.debug(NAME) { "#menu_cache(#{layout}, #{index}, #{chars})" }
          cache.write!(layout, index => chars)
        end

        # This will never have text, it's purely to render.
        def menu_write(layout:, index:, chars:)
          logger.debug(NAME) { "#menu_write(#{layout}, #{index}, #{chars})" }
        end
      end
    end
  end
end
