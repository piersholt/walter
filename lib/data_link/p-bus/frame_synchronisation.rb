# frozen_string_literal: true

module PBus
  class Frame
    class Synchronisation
      include DataTools
      attr_reader :buffer, :frame

      SYNC = 'Sync /'
      SYNC_HEADER = 'Header /'
      SYNC_TAIL = 'Tail /'
      SYNC_VALIDATION = 'Validate /'
      SYNC_SHIFT = 'Unshift! /'

      def initialize(buffer, opts = { offset: 0 })
        @buffer = buffer
        @offset = opts[:offset]
      end

      def run
        shift
      end

      def pre_fcs
        frame[0..-2].join(' ')
      end

      def fcs
        frame[-1..-1].join(' ')
      end

      def formatted_checksum
        d2h(checksum)
      end

      def formatted_frame
        "#{pre_fcs} [#{fcs}] == #{formatted_checksum} => #{frame_check}"
      end

      def shift(read_buffer = [], read_length = 4)
        @frame = read_buffer + buffer.shift(read_length)
        validate_frame
        LogActually.datalink.debug(name) { formatted_frame }
        frame
      rescue ChecksumError => e
        LogActually.datalink.warn(name) { formatted_frame }
        shift(frame, 1)
      end


      private

      def name
        'Synchronisation'
      end

      def checksum
        frame[0..-2].reduce(0) { |x, y| x^=y.d }
      end

      def frame_check
        checksum == frame[-1].d
      end

      def validate_frame
        result = frame_check
        # LogActually.datalink.debug(name) { "#{checksum} == #{frame[-1].d} => #{result}" }
        raise ChecksumError unless result
      end
    end
  end
end
