# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Model
          module Encoding
            # Context::UserInterface::Model::Characters::ControlCharacters
            class ControlCharacters < UIKit::Model::List
              PROG = 'Characters::ControlCharacters'
              ASCII = ::Encoding::ASCII_8BIT

              # CONTROL CHARACTERS
              C_NULL         = 0x00
              CONTROL_FLASH  = 0x01
              CONTROL_CR     = 0x06

              def initialize(index = 0, page_size = 5)
                list_items = carriage_return + flash + nullified + control_pairs(page_size)
                super(list_items, index: index, page_size: page_size)
              end

              # two lines per thingo
              def carriage_return
                lines = (65..90).step(16).map do |code|
                  a = Array.new(8) { |i| code + i }
                  b = Array.new(8) { |i| (code + 8) + i }
                  a + [CONTROL_CR] + b
                end

                lines.unshift(encode('Psuedo-Carriage Return 0x06'))

                indexes = 1.step(4, 2).map { |i| i }
                indexes.unshift(0)
                lines.map.with_index do |line, index|
                  offset_index = indexes[index]
                  [offset_index, line]
                end
              end

              def control_pairs(page_size)
                # range = ((0x00..0x05).to_a + (0x07..0x09).to_a + (0x11..0x1f).to_a)
                range = (0x00..0x1f).to_a
                range.permutation(2).to_a.shuffle.map do |x, y|
                  # puts x.to_s + ' ' + y.to_s
                  chars = '"AAA BBB CCC"'.encode(ASCII).bytes
                  chars.unshift(*("[#{x.to_s(16)}\t#{y.to_s(16)}]\t".encode(ASCII).bytes))
                  chars.insert(-1, x)
                  chars.insert(-1, y)
                  # chars.insert(0, y)
                  # chars.insert(0, x)
                  chars
                  # chars.map(&:chr).join
                end.map.with_index do |x, i|
                  # LOGGER.unknown(PROG) { "x: #{x}, i: #{i}" }
                  # puts x
                  # puts i
                  [i.modulo(page_size), x]
                end
                # (0x00..0x1f).to_a.permutation(2).map.with_index do |c1, c2, i|
                #   chars = Array.new(10) { Random.rand(97..122) }
                #   chars.insert(5, c2)
                #   chars.insert(5, c1)
                #
                #   [i.modulo(page_size), chars.map(&:chr).join]
                # end
              end

              # flashing text!
              def flash
                heading = encode('Flash 0x01')

                line1 = encode('Flashing Text!')
                line1.unshift(CONTROL_FLASH)

                line2 = encode('Sadly, not flashing :(')

                [[0, heading], [1, line1], [2, line2]]
              end

              # c style null
              def nullified
                heading = encode('C Null String 0x00')
                line1 = encode('"I didn\'t even finish my sentence!"')
                line2 = line1.dup.insert(-5, 0x00)

                [[0, heading], [1, line1], [2, line2]]
              end

              def encode(string)
                string.encode(ASCII).bytes
              end
            end
          end
        end
      end
    end
  end
end
