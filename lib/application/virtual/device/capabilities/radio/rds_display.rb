# frozen_string_literal: true

module Capabilities
  module Radio
    # RDS Display
    module RDSDisplay
      include API::Radio
      include Constants
      include DataTools

      def pad_chars(string, required_length)
        Kernel.format("%-#{required_length}s", string)
      end

      # --------------------------------------------------------------------- #

      # Title 11 chars
      def title(gfx: LAYOUT_HEADER,
                ike: ZERO,
                chars: genc(LENGTH_TITLE))
        padded_chars = pad_chars(chars, LENGTH_TITLE)
        primary(gfx: gfx, ike: ike, chars: padded_chars)
      end

      # Subtitles 20 chars
      def subheading_a(layout: LAYOUT_HEADER,
                       padding: PADDING_NONE,
                       zone: INDEX_FIELD_6,
                       chars: genc(LENGTH_SUBHEADING))
        padded_chars = pad_chars(chars, LENGTH_SUBHEADING)
        secondary(layout: layout, padding: padding, zone: zone, chars: padded_chars)
      end

      # Subtitles 20 chars
      def subheading_b(layout: LAYOUT_HEADER,
                       padding: PADDING_NONE,
                       zone: INDEX_FIELD_7,
                       chars: genc(LENGTH_SUBHEADING))
        padded_chars = pad_chars(chars, LENGTH_SUBHEADING)
        secondary(layout: layout, padding: padding, zone: zone, chars: padded_chars)
      end

      def a1(layout: LAYOUT_HEADER,
             padding: PADDING_NONE,
             zone: INDEX_FIELD_1,
             chars: genc(LENGTH_A))
        padded_chars = pad_chars(chars, LENGTH_A)
        secondary(layout: layout, padding: padding, zone: zone, chars: padded_chars)
      end

      def a2(layout: LAYOUT_HEADER,
             padding: PADDING_NONE,
             zone: INDEX_FIELD_2,
             chars: genc(LENGTH_A))
        secondary(layout: layout, padding: padding, zone: zone, chars: chars)
      end

      def a3(layout: LAYOUT_HEADER,
             padding: PADDING_NONE,
             zone: INDEX_FIELD_3,
             chars: genc(LENGTH_A))
        secondary(layout: layout, padding: padding, zone: zone, chars: chars)
      end

      def b1(layout: LAYOUT_HEADER,
             padding: PADDING_NONE,
             zone: INDEX_FIELD_4,
             chars: genc(LENGTH_B))
        secondary(layout: layout, padding: padding, zone: zone, chars: chars)
      end

      def b2(layout: LAYOUT_HEADER,
             padding: PADDING_NONE,
             zone: INDEX_FIELD_5,
             chars: genc(LENGTH_B))
        secondary(layout: layout, padding: padding, zone: zone, chars: chars)
      end

      def render_menu(layout:)
        secondary(layout: layout,
                  padding: PADDING_NONE,
                  zone: NO_INDEX,
                  chars: NO_CHARS)
      end

      def render(layout)
        secondary(layout: layout,
                  padding: PADDING_NONE,
                  zone: NO_INDEX,
                  chars: NO_CHARS)
      end

      def clear(layout: LAYOUT_HEADER, indices: FIELD_INDEXES)
        indices.each do |index|
          secondary(layout: layout,
                    padding: PADDING_NONE,
                    zone: index,
                    chars: CLEAR_CHARS)
        end
      end

      # ------------------------------- MACROS ------------------------------- #

      def generate_header(layout: LAYOUT_HEADER, indices: (0x1..0x7))
        indices.each do |index|
          secondary(layout: layout,
                    padding: PADDING_NONE,
                    zone: index,
                    chars: generate_a5(layout, index))
          wait
        end
      end

      # the layout must match
      def generate_menu(layout: LAYOUT_MENU_B, indices: ITEM_INDEXES)
        indices.each do |index|
          list(m1: layout,
               m2: ZERO,
               m3: index,
               chars: generate_21(layout, index))
          wait
        end
        Kernel.sleep(1)
        render_menu(layout: layout)
        true
      end

      # (0x00..0xFF).step(5).each {|i| bus.rad.menu(layout: 0x60, indices: (i..i+8).to_a); Kernel.sleep(2); }

      # the layout must match
      def menu(layout: LAYOUT_MENU_A, padding: PADDING_NONE, indices: ITEM_INDEXES)
        indices.each do |index|
          secondary(layout: layout,
                    padding: padding,
                    zone: index,
                    chars: generate_a5(layout, index))
          wait
          # Kernel.sleep(1)
        end
        # Kernel.sleep(1)
        # render_menu(layout: layout)
        true
      end

      def generate_a5(layout, index)
        "a5 #{d2h(layout)} #{d2h(index)} #{genc(20)}"
      end

      def generate_21(layout, index)
        "21 #{d2h(layout)} #{d2h(index)} #{genc(20)}"
      end
    end
  end
end
