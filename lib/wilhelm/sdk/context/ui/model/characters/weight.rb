# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Model
          module Characters
            # Context::UserInterface::Model::Characters::Pixel
            class Weight < UIKit::Model::List
              include Observable
              PROG = 'Characters::Weight'
              DEFAULT_WIDTH = 8
              DEFAULT_DELTA = 1

              unweighed_chars = (65..90).to_a + (97..122).to_a

              weighed_chars =
              %w[W w] +
              %w[M m] +
              %w[Q] +
              %w[A D G K N O V X Y x] +
              %w[B H R T U b d e g h n p q u v y] +
              %w[C P S Z a o k] +
              %w[E F L c t z] +
              %w[f r s] +
              %w[J] +
              %w[j] +
              %w[l i I]
              weighed_chars = weighed_chars.map(&:bytes).flatten

              LIST_ITEMS = weighed_chars | unweighed_chars

              def initialize(weight = DEFAULT_WIDTH, index = 0, page_size = 5)
                list_items = LIST_ITEMS.map do |i|
                  { ordinal: i  }
                end
                super(list_items, index: index, page_size: page_size)
                @width = weight
              end

              # WIDTH

              def reset!
                @width = DEFAULT_WIDTH
              end

              def width
                @width ||= DEFAULT_WIDTH
              end

              def backward
                super
                changed
                notify_observers(self)
              end

              def forward
                super
                changed
                notify_observers(self)
              end

              def less!(interval = DEFAULT_DELTA)
                @width -= interval
                LOGGER.unknown(PROG) { "less! => #{@width}" }
              end

              def more!(interval = DEFAULT_DELTA)
                @width += interval
                LOGGER.unknown(PROG) { "more! => #{@width}" }
              end

              # CONTROL CHARACTERS

              C_NULL = 0x00
              FLASH = 0x01
              CR    = 0x06
            end
          end
        end
      end
    end
  end
end
