# frozen_string_literal: true

module Capabilities
  module Radio
    # CD Changer Reqests
    module NavigationDisplay
      include API::Radio
      include Constants
      include DataTools

      # --------------------------------------------------------------------- #

      # Title 11 chars
      def title(gfx: LAYOUT_HEADER,
                ike: 0x30,
                chars: genc(11))
        primary(gfx: gfx, ike: ike, chars: chars)
      end

      # Subtitles 20 chars
      def h2(layout: LAYOUT_HEADER,
             padding: PADDING_NONE,
             zone: INDEX_FIELD_6,
             chars: genc(20))
        secondary(layout: layout, padding: padding, zone: zone, chars: chars)
      end

      # Subtitles 20 chars
      def h3(layout: LAYOUT_HEADER,
             padding: PADDING_NONE,
             zone: INDEX_FIELD_7,
             chars: genc(10))
        secondary(layout: layout, padding: padding, zone: zone, chars: chars)
      end

      # ------------------------------- 0xa5 ------------------------------- #

      # ok, if CD Track XX comes up due to track change
      # it doesn't erase the menus
      # if i'm on 0x23 62.. then track changes
      # when i pull up the menus they're still in memory

      # i want to try blocking here.. can i draw all, then mass update?
      def header_a5(layout: LAYOUT_HEADER)
        FIELD_INDEXES.each do |field_id|
          item_a5(layout: layout, padding: PADDING_NONE, zone: field_id, chars: "a5#{d2h(layout)}#{d2h(field_id)}#{geni(1)}")
          wait
        end
        # flush(layout: LAYOUT_MENU_A)
      end

      def clear_a5(layout: LAYOUT_HEADER)
        FIELD_INDEXES.each do |field_id|
          item_a5(layout: layout, padding: PADDING_NONE, zone: field_id, chars: CLEAR_CHARS)
          Kernel.sleep(0.01)
        end
        # flush(layout: LAYOUT_MENU_A)
      end

      # current issue is this doesn't draw row 1 column 1
      # it was the same with.... both indexes...
      # interestingly 0x60 _does_ draw menus....

      # when you use this... every messget gets GFX-STATUS reply...
      # i can see the screen visibly dim...
      # is there a block/unblock argument?
      # well... what do you know... 0b0100_0000 stops refresh...
      # or because.... it's not a valid field, so it does nothing...?

      # menu A5 _kinda_ works...
      # def menu_a5(layout: LAYOUT_MENU_A, padding: PADDING_NONE, index: ITEM_INDEXES)
      #   index.each do |index_id|
      #     item_a5(layout: layout, padding: padding, zone: index_id)
      #     wait
      #   end
      #   flush(layout: layout)
      # end

      def item_a5(layout:,
                  padding:,
                  zone: rfi,
                  chars: "a5_#{d2h(layout)}_#{d2h(zone)}_#{genc(2)}")
        secondary(layout: layout,
                  padding: padding,
                  zone: zone,
                  chars: chars)
      end

      def flush(layout:)
        secondary(layout: layout,
                  padding: PADDING_NONE,
                  zone: NO_INDEX,
                  chars: NO_CHARS)
      end

      # ------------------------------- 0x21 ------------------------------- #

      # current issue it doesn't refresh
      # that was independent of index IDs
      # the documents do say use (A5 60 01 00 '')

      def menu_21(layout: LAYOUT_MENU_A, index: ITEM_INDEXES)
        index.each do |index_id|
          item_21(layout: layout, zone: index_id, chars: "#{d2h(layout)}_#{d2h(index_id)}_#{genc(1)}")
          wait
        end
        # the layout must match
        flush(layout: layout)
      end

      def item_21(layout:,
                  m2: 0x01,
                  zone:,
                  chars:)
        list(m1: layout,
             m2: m2,
             m3: zone,
             chars: chars)
      end

      # ------------------------------------------------------------------- #

      def rii
        index = Random.rand(0..(ITEM_INDEXES.length - 1))
        ITEM_INDEXES[index]
      end

      def rfi
        index = Random.rand(0..(FIELD_INDEXES.length - 3))
        FIELD_INDEXES[index]
      end
    end
  end
end
