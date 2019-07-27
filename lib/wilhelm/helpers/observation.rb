# frozen_string_literal: true

module Wilhelm
  module Helpers
    # Audio::Player::Observation
    module Observation
      include Observable
      include Helpers::Object

      PROG = self.class

      alias add_observer! add_observer
      alias delete_observer! delete_observer

      # @override Observeable#add_obvserver
      def add_observer(object, method = :update)
        logger.debug(PROG) { "#add_observer(#{hid(object)})" }
        validate_observer(object)
        add_observer!(object, method)
      end

      # @override Observeable#delete_observer
      def delete_observer(object)
        logger.debug(PROG) { "#delete_observer(#{hid(object)})" }
        delete_observer!(object)
      end

      def observers
        @observer_peers&.map do |observer, method|
          [human_id(observer), method]
        end&.to_h
      end

      private

      def duplicate?(object)
        @observer_peers&.any? do |observer, _|
          observer.class == object.class
        end
      end

      def validate_observer(object)
        return true unless duplicate?(object)
        raise(ArgumentError, duplicate_msg(object))
      end

      def duplicate_msg(object)
        "#{hid(object)} is already observing #{hid(self)}"
      end
    end
  end
end
