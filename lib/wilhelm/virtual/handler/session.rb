# frozen_string_literal: false

module Wilhelm
  module Virtual
    class SessionHandler < Core::BaseHandler
      include Singleton

      METRICS = [BYTE_RECEIVED, FRAME_RECEIVED, FRAME_FAILED, MESSAGE_RECEIVED]

      attr_reader :messages, :frames
      attr_writer :transmission_sequence

      def self.i
        instance
      end

      def initialize
        @messages = Messages.new
        @frames = []
      end

      def inspect
        "<SessionHandler frames:#{stats[:frame]&.length} messages: #{stats[:message]&.length}>"
      end

      def add_byte(byte_basic)
        # print byte_basic
        bytes[transmission_sequence] << byte_basic
      end

      def add_message(message)
        @messages << message
      end

      def add_frame(frame)
        @frames << frame
      end

      def update(action, properties)
        LOGGER.debug(name) { "\t#update(#{action}, #{properties})" }
        case action
        when BYTE_RECEIVED
          # add_byte(properties[:byte_basic])
          update_stats(action)
        when FRAME_FAILED
          update_stats(action)
        when FRAME_RECEIVED
          update_stats(action)
          add_frame(properties[:frame])
        when MESSAGE_RECEIVED
          update_stats(action)
          add_message(properties[:message])
        end
      end

      def message_received(properties)
        update_stats(MESSAGE_RECEIVED)
        add_message(properties[:message])
      end

      def stats
        @stats ||= METRICS.map do |metric|
          [metric, 0]
        end.to_h
      end

      # FBZV

      def bytes
        @bytes ||= {}
      end

      def increment
        self.transmission_sequence = transmission_sequence + 1
        bytes[transmission_sequence] = []
      end

      def transmission_sequence
        @transmission_sequence ||= 0
      end

      private

      def update_stats(metric)
        stats[metric] += 1
      end
    end
  end
end
