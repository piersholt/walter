# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      module Synchronisation
        # Frame synchronisation for Instrument (I), and Body, i.e. Karosserie (K) buses.
        class Instrument
          include Constants
          NAME = 'Sync::I/K_Bus'

          attr_reader :buffer, :frame

          def initialize(buffer, frame = Frame.new)
            @buffer = buffer
            @frame = frame
          end

          def run
            fetch_frame_header
            fetch_frame_tail
            validate_frame
            frame
          rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
            LOGGER.debug(name) { "#{e}!" }
            LOGGER.debug(name) { "Rasing: #{e}" }
            raise e
          end

          private

          def name
            NAME
          end

          def buffer?(log)
            LOGGER.debug(name) { "#{log} Byte Buffer size: #{buffer.size + buffer.register}. (Buffer: #{buffer.size}, Unshifted: #{buffer.register})" }
          end

          def fetch_frame_header
            buffer?(SYNC_HEADER)

            LOGGER.debug(name) { "#{SYNC_HEADER} Shifting #{Frame::HEADER_LENGTH} bytes." }
            header = buffer.shift(Frame::HEADER_LENGTH)
            LOGGER.debug(name) { "#{SYNC_HEADER} Shifted bytes: #{header}" }

            # LOGGER.debug(SYNC_HEADER) { "Setting new frame header." }
            frame.set_header(header)
            # LOGGER.debug(name) { "#{SYNC_HEADER} New frame header set: #{frame.header}" }
          rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
            raise e
          rescue StandardError => e
            LOGGER.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
            e.backtrace.each { |l| LOGGER.warn(l) }
          end

          def fetch_frame_tail
            buffer?(SYNC_TAIL)
            remaining_bytes = read_length_from_header

            LOGGER.debug(name) { "#{SYNC_TAIL} Shifting #{remaining_bytes} bytes." }
            tail = buffer.shift(remaining_bytes)
            LOGGER.debug(name) { "#{SYNC_TAIL} Shifted bytes: #{tail}" }

            # LOGGER.debug(SYNC_TAIL) { "Setting new frame tail." }
            frame.set_tail(tail)
            # LOGGER.debug(name) { "#{SYNC_TAIL} New frame tail set: #{frame.tail}" }
          rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
            raise e
          rescue StandardError => e
            LOGGER.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
            e.backtrace.each { |l| LOGGER.warn(l) }
          end

          def read_length_from_header
            LOGGER.debug(name) { "#{SYNC_HEADER} Reading frame length from header." }
            outstanding = frame.header.tail_length
            LOGGER.debug(name) { "#{SYNC_HEADER} Remaining frame bytes: #{outstanding}" }
            outstanding
          rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
            raise e
          rescue StandardError => e
            LOGGER.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
            e.backtrace.each { |l| LOGGER.warn(l) }
          end

          def validate_frame
            LOGGER.debug(name) { "#{SYNC_VALIDATION} Validating new frame." }
            raise ChecksumError unless frame.valid?
            LOGGER.debug(name) { "#{SYNC} Valid! #{frame}" }
          rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
            # Need to rescue and raise this again otherwise StandardError rescue buggers it up
            # LogActuall
            raise e
          rescue StandardError => e
            LOGGER.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
            e.backtrace.each { |l| LOGGER.warn(l) }
          end
        end
      end
    end
  end
end
