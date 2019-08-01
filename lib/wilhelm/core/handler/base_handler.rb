# frozen_string_literal: true

module Wilhelm
  module Core
    # Core::BaseHandlerError
    class BaseHandlerError < StandardError
      MESSAGE = 'BaseHandler Error'
      def message
        MESSAGE
      end
    end
  end
end

module Wilhelm
  module Core
    # Core::BaseHandler
    class BaseHandler
      include Observable
      include Constants::Events
      include Helpers

      PROG = 'Handler::Base'

      def name
        self.class.name
      end

      def fetch(props, key)
        raise BaseHandlerError, "#{key} is not in properties!" unless props.key?(key)
        object = props[key]
        raise BaseHandlerError, "#{key} is nil!" if object.nil?
        object
      end

      def handle(action, properties)
        update(action, properties)
      rescue StandardError => e
        LOGGER.error(PROG) { e }
        e.backtrace.each { |line| LOGGER.error(PROG) { line } }
        binding.pry
      end
    end
  end
end
