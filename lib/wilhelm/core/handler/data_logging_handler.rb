# frozen_string_literal: false

module Wilhelm
  module Core
    # Comment
    class DataLoggingHandler < BaseHandler
      include Singleton

      def self.i
        instance
      end

      def inspect
        str_buffer = "<DataLoggingHandler>"
      end

      NAME = 'Core::DataLogging'.freeze

      def name
        NAME
      end

      def update(action, properties)
        case action
        when BYTE_RECEIVED
          byte_received(properties)
        when FRAME_RECEIVED
          frame_received(properties)
        when BUS_ONLINE
          bus_online
        when BUS_OFFLINE
          bus_offline
        when EXIT
          exit
        end
      rescue StandardError => e
        LOGGER.error(name) { e }
        e.backtrace.each { |line| LOGGER.error(line) }
      end

      def byte_received(properties)
        read_byte = fetch(properties, :read_byte)
        log_byte(read_byte)
      end

      def frame_received(properties)
        frame = fetch(properties, :frame)
        log_frame(frame)
      end

      def bus_online
        LOGGER.info(name) { 'Bus Online! Enable logging.' }
        enable_logging
      end

      def bus_offline
        LOGGER.warn(name) { 'Bus Offline! Disabling logging.' }
        disable_logging
      end

      def exit
        LOGGER.info(name) { 'Exit: Closing log files.' }
        close_log_files
      end

      private

      def byte_log
        @log_stream ||= ::File.new("log/bin/#{Time.now.strftime'%F'}.bin",  'a')
      end

      def frame_log
        @log_frames ||= ::File.new("log/frame/#{Time.now.strftime'%F'}.log",  'a')
      end

      def log_byte(next_byte)
        # LOGGER.debug("#{self.class}#log_byte(#{Byte.new(:encoded, next_byte).to_s(true)})")
        return false unless logging_enabled?
        bytes_written = byte_log.write(next_byte) if logging_enabled?
        # LOGGER.debug("Byte Log: #{bytes_written} bytes written.")
      end

      def log_frame(validated_frame)
        LOGGER.debug(name) { "#{self.class}#log_frame(#{validated_frame})" }
        LOGGER.debug(name) { "#{self.class}#logging_enabled? => #{logging_enabled?}" }
        return false unless logging_enabled?
        bytes_written = frame_log.write("#{validated_frame}\n") if logging_enabled?
        LOGGER.debug(name) { "Frame Log: #{bytes_written} bytes written." }
      end

      def logging_enabled?
        if @stream_logging == false
          return false
        elsif @stream_logging.nil?
          raise StandardError, 'no logging preference...'
        elsif @stream_logging == true
          return true
        end
      end

      def disable_logging
        LOGGER.debug(name) { 'Logging disabled!' }
        @stream_logging = false
      end

      def enable_logging
        LOGGER.debug(name) { 'Logging enabled!' }
        @stream_logging = true
      end

      def close_log_files
        disable_logging
        LOGGER.debug(name) { "Closing binary stream log #{byte_log.path}." }
        byte_log.close
        LOGGER.info(name) { "#{byte_log.path} closed." }
        LOGGER.debug(name) { "Closing frame log #{frame_log.path}." }
        frame_log.close
        LOGGER.info(name) { "#{frame_log.path} closed." }
      end
    end
  end
end
