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
                ike: 0b0001_0000,
                chars: genc(LENGTH_TITLE))
        padded_chars = pad_chars(chars, LENGTH_TITLE)
        primary(gfx: gfx, ike: ike, chars: padded_chars)
      end

      # Subtitles 20 chars
      def h2(layout: LAYOUT_HEADER,
                       padding: PADDING_NONE,
                       zone: INDEX_FIELD_6,
                       chars: genc(LENGTH_SUBHEADING))
        padded_chars = pad_chars(chars, LENGTH_SUBHEADING)
        secondary(layout: layout, padding: padding, zone: zone, chars: padded_chars)
      end

      def h2!(chars = nil)
        chars ? h2(chars: chars, zone: INDEX_FIELD_6 + 0b1000_0000) : h2(zone: INDEX_FIELD_6 +  + 0b1000_0000)
        # Kernel.sleep(2)
        render(LAYOUT_HEADER)
      end

      def h3!(chars = nil)
        chars ? h3(chars: chars, zone: INDEX_FIELD_7) : h3(zone: INDEX_FIELD_7)
        # Kernel.sleep(2)
        render(LAYOUT_HEADER)
      end

      # Subtitles 20 chars
      def h3(layout: LAYOUT_HEADER,
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

      def a1!(chars = nil)
        chars ? a1(chars: chars, zone: INDEX_FIELD_1) : a1(zone: INDEX_FIELD_1)
        # Kernel.sleep(2)
        render(LAYOUT_HEADER)
      end

      def a2!(chars = nil)
        chars ? a2(chars: chars, zone: INDEX_FIELD_2) : a2(zone: INDEX_FIELD_2)
        # Kernel.sleep(2)
        render(LAYOUT_HEADER)
      end

      def a3!(chars = nil)
        chars ? a3(chars: chars, zone: INDEX_FIELD_3) : a3(zone: INDEX_FIELD_3)
        # Kernel.sleep(2)
        render(LAYOUT_HEADER)
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

      def b1!(chars = nil)
        chars ? b1(chars: chars, zone: INDEX_FIELD_4) : b1(zone: INDEX_FIELD_4)
        # Kernel.sleep(2)
        render(LAYOUT_HEADER)
      end

      def b2(layout: LAYOUT_HEADER,
             padding: PADDING_NONE,
             zone: INDEX_FIELD_5,
             chars: genc(LENGTH_B))
        secondary(layout: layout, padding: padding, zone: zone, chars: chars)
      end

      def b2!(chars = nil)
        chars ? b2(chars: chars, zone: INDEX_FIELD_5) : b2(zone: INDEX_FIELD_5)
        # Kernel.sleep(2)
        render(LAYOUT_HEADER)
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

      def build_header(layout, fields_with_index, title = nil)
        FIELD_INDEXES.each_with_index do |field_index, index|
          field = fields_with_index.fetch(index, false)
          next unless field
          list(m1: layout,
               m2: ZERO,
               m3: field_index,
               chars: field.to_s)
        end
        title(gfx: layout, chars: title) if title
        render(layout) unless title
        true
      end

      def build_new_header(layout, fields_with_index, title = nil)
        FIELD_NEW_INDEXES.each_with_index do |field_index, index|
          field = fields_with_index.fetch(index, false)
          next unless field
          secondary(layout: layout,
                    padding: PADDING_NONE,
                    zone: field_index,
                    chars: field.to_s)
        end
        title(gfx: layout, chars: title) if title
        render(layout) unless title
        true
      end

      def build_menu(layout, menu_items_with_index)
        ITEM_INDEXES.each_with_index do |item_index, index|
          menu_item = menu_items_with_index.fetch(index, false)
          next unless menu_item
          list(m1: layout,
               m2: ZERO,
               m3: item_index,
               chars: menu_item.to_s)
        end
        render_menu(layout: layout)
        true
      end

      # ------------------------------- MACROS ------------------------------- #

      def generate_header(layout: LAYOUT_HEADER, indices: (0x41..0x47))
        indices.each do |index|
          secondary(layout: layout,
                    padding: PADDING_NONE,
                    zone: index,
                    chars: generate_a5(layout, index))
          wait
        end
      end

      # the layout must match
      def generate_menu(layout: LAYOUT_MENU_A, indices: ITEM_INDEXES)
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

      def extreme
        @extreme ||= 20
      end

      def generate_21(layout, index)
        "21 #{d2h(layout)} #{d2h(index)} #{genc(20)}"
      end
    end
  end
end
