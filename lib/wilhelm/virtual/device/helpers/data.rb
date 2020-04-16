# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Helpers
        # Device::Helpers
        module Data
          include Wilhelm::Helpers::Parse

          def wait
            Kernel.sleep(0.01)
          end

          def generate_ints(length = 1)
            Array.new(length) do
              Random.rand(0..9)
            end.join
          end

          def generate_chars(length = 20, range = 0x21..0x7a)
            length = Random.rand(length) if length.is_a?(Range)
            Array.new(length) do
              Random.rand(range)
            end
          end

          def generate_string(length = 20, range = 0x21..0x7a)
            length = Random.rand(length) if length.is_a?(Range)
            Array.new(length) do
              Random.rand(range).chr
            end.join
          end

          def delimitered_chars(delimiter = 6, items = 2)
            Array.new(items) do
              "#{delimiter.chr}#{gens(5)}"
            end.join
          end

          alias genc generate_chars
          alias gens generate_string
          alias geni generate_ints
        end
      end
    end
  end
end
