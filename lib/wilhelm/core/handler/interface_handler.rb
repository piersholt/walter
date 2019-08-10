# frozen_string_literal: true

module Wilhelm
  module Core
    # Core::InterfaceHandler
    class InterfaceHandler < BaseHandler
      attr_accessor :transmitter

      def initialize(transitter)
        @transmitter = transitter
      end

      NAME = 'InterfaceHandler'

      def name
        NAME
      end

      def self.i
        instance
      end

      def bus_offline
        LOGGER.warn(name) { 'Bus Offline! Disabling transmission.' }
        transmitter&.disable
      end
    end
  end
end
