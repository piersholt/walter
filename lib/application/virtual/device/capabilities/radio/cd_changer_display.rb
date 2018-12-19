# frozen_string_literal: true

module Capabilities
  module Radio
    # CD Changer Reqests
    module CDChangerDisplay
      include API::Radio

      # rad  gfx  23  CA 20  "CD 1-01",
      # rad  gfx  23  CA 20  "CD 1-01",
      # rad  gfx  23  CA 20  "CD 1-01",
      # rad  gfx  23  CA 20  "CD 1-01",

      # def alt(mode = :scanning)
      #   case mode
      #   when :scanning
      #
      #   end
      # end

      # [< >] Music search
      def seek(to: :gfx)
        output(to: to, gfx: 0xc4, ike: 0x20, chars: 'CD 7-99')
      end

      # rad  gfx  23  C5 20  "CD 1-01  >>",
      # rad  gfx  23  C5 20  "CD 1-01  >>",
      # rad  gfx  23  C5 20  "CD 1-01  >>",
      def fast_forward(to: :gfx)
        output(to: to, gfx: 0xc5, ike: 0x20, chars: 'CD 9-99 >>')
      end

      # rad  gfx  23  C6 20  "CD 1-01 <<R",
      def rewind(to: :gfx)
        output(to: to, gfx: 0xc6, ike: 0x20, chars: 'CD 9-99 <<R')
      end

      # [SCAN] Track samole
      # rad     gfx     23      C7 20   "CD 1-13  SC"
      # rad     gfx     23      C7 20   "CD 1-14  SC"
      def sample(to: :gfx)
        output(to: to, gfx: 0xc7, ike: 0x20, chars: 'CD 7-99')
      end

      # [RANDOM] Random generator
      # rad     gfx     23      C8 20   "CD 1-11 RND"
      # rad     gfx     23      C8 20   "CD 1-12 RND"
      # rad     gfx     23      C8 20   "CD 1-13 RND"
      def shuffle(to: :gfx)
        output(to: to, gfx: 0xc8, ike: 0x20, chars: 'CD 7-99')
      end

      # [<< >>] Fast forward/reverse
      # rad  gfx  23  C4 20  "CD 1-01 << >>"
      # rad  gfx  23  C4 20  "CD 1-01 << >>"
      def scan(to: :gfx, chars: 'CD 7-99')
        output(to: to, gfx: 0xca, ike: 0x20, chars: chars)
      end

      def example
        # '01234567891BCDEF_0123456789ABCDEF'
        'Test A'
      end

      def zone_example
        "\bCD 1-05  "
      end

      def number(length = 1)
        Array.new(length) do
          Random.rand(0..9)
        end.join
      end

      def jumble(length = 20, range = 0x21..0x7a)
        # length.times.map {  }.join
        Array.new(length) do
          Random.rand(range).chr
        end.join
      end

      def menu_example
        delim = 6
        "#{delim.chr}#{jumble(5)}#{delim.chr}#{jumble(5)}"
      end

      def nav_loop
        @results = {}
        (0x00..0xFF).each do |i|
          puts DataTools.d2h(i)
          public_send(:nav, to: :gfx, zone: i, chars: jumble)
          Kernel.sleep(0.5)
          # comment = gets
          # @results[i] = comment
        end
      end

      def zone(to: :gfx, gfx: 0x62, ike: 0x30, chars: zone_example)
        output(to: to, gfx: gfx, ike: ike, chars: chars)
      end

      def nav(to: :gfx, gfx: 0x62, zone: 0x05, chars: example)
        output_alt(to: to, gfx: gfx, ike: 0x01, zone: zone, chars: chars)
      end

      def menu(to: :gfx, m1: 0x60, m2: 0x00, m3: 0x60, chars: menu_example)
        index(to: to, m1: m1, m2: m2, m3: m3, chars: chars)
      end

      PAGE = { 0 => 0b0110_0000, 1 => 0b0100_0100,
               2 => 0b0101_0000, 3 => 0b0001_0100 }.freeze

      def menu_macro
        menu(m1: 60, m3: PAGE[0], chars: menu_example)
        Kernel.sleep(0.01)
        menu(m1: 60, m3: PAGE[1], chars: menu_example)
        Kernel.sleep(0.01)
        menu(m1: 60, m3: PAGE[2], chars: menu_example)
        Kernel.sleep(0.01)
        menu(m1: 60, m3: PAGE[3], chars: menu_example)
        Kernel.sleep(0.01)
      end
    end
  end
end
