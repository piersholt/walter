# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Handler
      # Comment
      class MessageHandler < Core::BaseHandler
        include LogActually::ErrorOutput

        NAME = 'MessageHandler'.freeze

        def name
          NAME
        end

        def initialize(bus, packet_output_buffer)
          @bus = bus
          @packet_output_buffer = packet_output_buffer
          register_devices(@bus.devices)
          register_tx_devices(@bus.dynamic)
          register_for_broadcast(@bus.simulated)
        end

        def message_received(properties)
          # LOGGER.warn(self.class) { "#message_received" }
          message = message?(properties)
          route_to_senders(message)
          route_to_receivers(message)
        end

        def message_sent(properties)
          # LOGGER.debug(name) { "#message_sent(#{action}, #{properties})" }
          message = message?(properties)
          add_to_output_buffer(message)
        rescue StandardError => e
          with_backtrace(LOGGER, e)
        end

        private

        def message?(properties)
          message = fetch(properties, :message)
          raise RoutingError, 'Message is nil!' unless message
          message
        end

        def route_to_receivers(packet)
          # LOGGER.warn(self.class) { "#route_to_receivers" }
          recipient = packet.to
          raise RoutingError, 'Recipient is nil!' unless recipient
          observers = subscribers[recipient]
          raise RoutingError, "No observers of #{recipient}" if observers.nil? || observers.empty?
          # return true
          observers.each do |subscriber|
            subscriber.virtual_receive(packet)
          end
        rescue RoutingError
          false
        end

        def route_to_senders(packet)
          # LOGGER.warn(self.class) { "#route_to_senders" }
          sender = packet.from
          raise RoutingError, 'Recipient is nil!' unless sender
          observers = publishers[sender]
          raise RoutingError, "No observers of #{sender}" if observers.nil? || observers.empty?
          # return true
          observers.each do |publisher|
            publisher.virtual_transmit(packet)
          end
        rescue RoutingError
          false
        end

        def add_to_output_buffer(message)
          result = @packet_output_buffer.push(message)
          LOGGER.debug(name) { "#add_to_output_buffer(#{message}) => #{result}" }
          result
        end

        def register_devices(devices)
          devices.each do |device|
            register_device(device.ident, device)
          end
        end

        def register_tx_devices(devices)
          devices.each do |device|
            register_tx_device(device.ident, device)
          end
        end

        def register_device(to_ident, observer)
          subscribers(to_ident) << observer
        end

        def register_tx_device(to_ident, observer)
          publishers(to_ident) << observer
        end

        def register_for_broadcast(devices)
          devices.each do |device|
            register_device(:glo_l, device)
            register_device(:glo_h, device)
          end
        end

        def subscribers(ident = nil)
          if ident.nil?
            return_value = @subscribers ||= {}
            return_value
          else
            var = subscribers
            if var.key?(ident)
              return_value = var[ident]
            else
              var[ident] = []
              return_value = var[ident]
            end

            return_value
          end
        end

        def publishers(ident = nil)
          if ident.nil?
            return_value = @publishers ||= {}
            return_value
          else
            var = publishers
            if var.key?(ident)
              return_value = var[ident]
            else
              var[ident] = []
              return_value = var[ident]
            end

            return_value
          end
        end
      end
    end
  end
end
