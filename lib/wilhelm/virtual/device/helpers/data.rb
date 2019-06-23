# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Helpers
        # Parse arguments for raw device APIs
        module Parse
          def integers_to_byte_array(*integers)
            byte_array = integers.map do |i|
              Wilhelm::Core::Byte.new(:decimal, i)
            end
            Core::Bytes.new(byte_array)
          end

          alias bytes integers_to_byte_array
        end

        # Comment
        module Data
          include Parse

          # BMBT::UserControls::UserControls
          alias integers_input bytes

          # Radio::Capabilities::CDChangerDisplay
          def integer_array_to_chars(array)
            array.map {|i| i.chr }.join
          end

          def wait
            Kernel.sleep(0.01)
          end

          def generate_ints(length = 1)
            Array.new(length) do
              Random.rand(0..9)
            end.join
          end

          def generate_chars(length = 20, range = 0x21..0x7a)
            Array.new(length) do
              Random.rand(range).chr
            end.join
          end

          def delimitered_chars(delimiter = 6, items = 2)
            items.times.map do
              "#{delimiter.chr}#{genc(5)}"
            end.join
          end

          alias genc generate_chars
          alias geni generate_ints
        end
      end
    end
  end
end
