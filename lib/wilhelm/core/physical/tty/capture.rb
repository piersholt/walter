# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      module TTY
        # Data logging
        module Capture
          DEFAULT_CAPTURE = false

          attr_reader :capture

          def capture_byte(byte)
            return false unless capture?
            byte_log.write(byte)
          end

          def capture_frame(frame)
            return false unless capture?
            frame_log.write("#{frame}\n")
          end

          def capture?
            @capture ||= DEFAULT_CAPTURE
          end

          def capture!
            LOGGER.info(name) { 'Bus Online! Enable logging.' }
            @capture = true
          end

          def release!
            LOGGER.info(name) { 'Bus Offline! Disabling logging.' }
            @capture = false
          end

          def close_capture
            release!
            close_byte_capture
            close_frame_capture
            true
          end

          def close_byte_capture
            LOGGER.debug(name) { "Closing binary stream log #{byte_log.path}." }
            result = byte_log.close
            LOGGER.info(name) { "#{byte_log.path} closed => #{result}" }
          end

          def close_frame_capture
            LOGGER.debug(name) { "Closing frame log #{frame_log.path}." }
            result = frame_log.close
            LOGGER.info(name) { "#{frame_log.path} closed => #{result}" }
          end

          def byte_log
            @byte_log ||= ByteStream.new
          end

          def frame_log
            @frame_log ||= FrameStream.new
          end
        end
      end
    end
  end
end
