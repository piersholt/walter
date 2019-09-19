# frozen_string_literal: true

module Wilhelm
  module Core
    # Core::InterfaceHandler
    class InterfaceHandler < BaseHandler
      attr_accessor :receiver, :transmitter

      def initialize(receiver, transmitter)
        @receiver = receiver
        @transmitter = transmitter
      end

      NAME = 'Handler::Interface'

      def name
        NAME
      end

      def self.i
        instance
      end

      def bus_online
        LOGGER.info(name) { 'Bus Online! Enable frame capture.' }
        receiver&.capture!
      end

      def bus_offline
        LOGGER.warn(name) { 'Bus Offline! Disabling transmission.' }
        transmitter&.disable
        LOGGER.warn(name) { 'Bus Offline! Disabling frame capture.' }
        receiver&.release!
      end
    end
  end
end
