# frozen_string_literal: true

class Vehicle
  class Display
    # Comment
    module CacheHandler
      NAME = 'CacheHandler'

      def header_cache(layout:, index:, chars:)
        logger.unknown(NAME) { "#update(#{header_cache}, #{properties})" }
        cache.public_send(layout)
             .attributes!(index => chars)
      end

      def header_write(layout:, index:, chars:)
        logger.unknown(NAME) { "#update(#{header_write}, #{properties})" }
        cache.public_send(layout)
             .attributes!(index => chars)
      end

      def menu_cache(layout:, index:, chars:)
        logger.unknown(NAME) { "#update(#{header_cache}, #{properties})" }
        cache.public_send(layout)
             .attributes!(index => chars)
      end

      def menu_write(layout:, index:, chars:)
        logger.unknown(NAME) { "#update(#{menu_write}, #{properties})" }
        cache.public_send(layout)
             .attributes!(index => chars)
      end
    end
  end
end
