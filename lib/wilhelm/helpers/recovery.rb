# frozen_string_literal: false

module Wilhelm
  module Helpers
    # Recovery
    module Recovery
      include Checksum
      include LogActually::ASCIIColour

      NAME = 'Recovery'.freeze
      MIN_WINDOW = 4
      START_INDEX = 0

      Segment = Struct.new(:valid, :string, :stream)

      # "F0 3B 21 43 01 14 06 41 70 70 6C 65 20 49 6E 63 2E 06 41 73 68 6C 65 79 20 41 72 64 C7"
      def sliding_recover(string)
        LOGGER.debug(NAME) { "#sliding_recover(#{string})" }
        bytes = s2i(string)
        segments = []
        dropped = []
        index = START_INDEX
        window_length = MIN_WINDOW

        while bytes.length >= MIN_WINDOW
          # puts "↘️\tbytes.length: #{bytes.length}"

          while window_length <= bytes.length
            # puts "➡️\tIndex: #{index}, Length: #{window_length}"
            window = bytes[index, window_length]
            puts "➡️\t#{as_yellow i2s(*window)} #{i2s(*bytes[window_length..-1])}"
            if recover(*window)
              unless dropped.empty?
                segments << Segment.new(false, i2s(*dropped[0..-1]), dropped[0..-1])
                dropped.clear
              end
              recovered_window = bytes.shift(window_length)
              puts "✅\t#{as_green i2s(*recovered_window)}"
              valid_window = recovered_window.insert(1, recovered_window.length - 1)
              segments << Segment.new(true, i2s(*valid_window), valid_window)
              index = START_INDEX
              window_length = MIN_WINDOW
              # puts "↘️\tbytes.length: #{bytes.length}"
            else
              window_length += 1
            end
          end

          window_length = MIN_WINDOW
          dropped_byte = bytes.shift
          dropped << dropped_byte if dropped_byte
          puts "❌\t#{as_red i2s(*dropped_byte)}" if dropped_byte
          index = 0
        end
        segments
      end

      # "F0 3B 21 43 01 14 06 41 70 70 6C 65 20 49 6E 63 2E 06 41 73 68 6C 65 79 20 41 72 64 C7"
      def recover(*bytes, checksum)
        LOGGER.debug(NAME) { "#recover(#{bytes}, #{checksum})" }
        bytes.length
        parity?(*bytes.insert(1, bytes.length), checksum)
      end

      private

      def as_red(string)
        "#{red}#{string}#{clear}"
      end

      def as_yellow(string)
        "#{yellow}#{string}#{clear}"
      end

      def as_green(string)
        "#{green}#{string}#{clear}"
      end
    end
  end
end
