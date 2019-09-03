# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      # API::Display::CacheHandler
      module CacheHandler
        NAME = 'CacheHandler'

        # @note #write! and #cache! are the same method

        def header_cache(layout:, index:, chars:)
          logger.debug(NAME) { "#header_cache(#{layout}, #{index}, #{chars})" }
          cache.public_send(layout).cache!(index => chars)
        end

        def header_write(layout:, index:, chars:)
          logger.debug(NAME) { "#header_write(#{layout}, #{index}, #{chars})" }
          cache.public_send(layout).write!(index => chars)
        end

        def menu_cache(layout:, index:, chars:)
          logger.debug(NAME) { "#menu_cache(#{layout}, #{index}, #{chars})" }
          cache.public_send(layout).overwrite!(index => chars)
        end

        # This will never have text, it's purely to render.
        def menu_write(layout:, index:, chars:)
          logger.debug(NAME) { "#menu_write(#{layout}, #{index}, #{chars})" }
          cache.public_send(layout).show!
        end
      end
    end
  end
end
