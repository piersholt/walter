# frozen_string_literal: true

class Vehicle
  class Display
    # Comment
    module CacheHandler
      NAME = 'CacheHandler'

      def header_cache(layout:, index:, chars:)
        logger.debug(NAME) { "#update(:header_cache, #{layout}, #{index}, #{chars})" }
        cache.public_send(layout)
             .cache!(index => chars)
      end

      def header_write(layout:, index:, chars:)
        logger.debug(NAME) { "#update(:header_write, #{layout}, #{index}, #{chars})" }
        cache.public_send(layout)
             .write!(index => chars)
      end

      def menu_cache(layout:, index:, chars:)
        logger.debug(NAME) { "#update(:header_cache, #{layout}, #{index}, #{chars})" }
        cache.public_send(layout)
             .cache!(index => chars)
      end

      # This will never have text, it's purely to render.
      def menu_write(layout:, index:, chars:)
        logger.debug(NAME) { "#update(:menu_write, #{layout}, #{index}, #{chars})" }
        cache.public_send(layout)
             .show!
      end
    end
  end
end
