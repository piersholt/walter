# frozen_string_literal: true

module Capabilities
  module Radio
    # CD Changer Reqests
    module NavigationDisplay
      include API::Radio

      # Title 11 chars
      def title(to: :gfx,
                gfx: 0x62, ike: 0x30,
                chars: genc(12))
        primary(to: to, gfx: gfx, ike: ike, chars: chars)
      end

      # Subtitles 20 chars
      def subtitle(to: :gfx,
                   gfx: 0x62, ike: 0x01,
                   zone: ZONE_H2,
                   chars: genc(20))
        secondary(to: to, gfx: gfx, ike: ike, zone: zone, chars: chars)
      end

      def index
        list(m1: 0x60, m2: 0x00, m3: i, chars: geni(5))
      end

      REFRESH = 0x00
      ZONE_A = 0b001
      ZONE_B = 0b010
      ZONE_C = 0b011
      ZONE_D = 0b100
      ZONE_E = 0b101
      ZONE_H2 = 0b110
      ZONE_H3 = 0b111

      # INDEXES = [0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49]
      INDEXES = [0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9]

      def h2
        sub_heading(zone: ZONE_H2)
      end

      def h3
        sub_heading(zone: ZONE_H3)
      end

      def zone(zone_id)
        case zone_id
        when :a
          sub_heading(zone: ZONE_A)
        when :b
          sub_heading(zone: ZONE_B)
        when :c
          sub_heading(zone: ZONE_C)
        when :d
          sub_heading(zone: ZONE_D)
        when :e
          sub_heading(zone: ZONE_E)
        end
      end

      def test_macro(gfx: 0x60)
        subtitle(gfx: gfx, ike: 0x00, zone: ZONE_A, chars: genc(5))
        Kernel.sleep(0.05)
        subtitle(gfx: gfx, ike: 0x00, zone: ZONE_B, chars: genc(5))
        Kernel.sleep(0.05)
        subtitle(gfx: gfx, ike: 0x00, zone: ZONE_C, chars: genc(5))
        Kernel.sleep(0.05)
        subtitle(gfx: gfx, ike: 0x00, zone: ZONE_D, chars: genc(5))
        Kernel.sleep(0.05)
        subtitle(gfx: gfx, ike: 0x00, zone: ZONE_E, chars: genc(5))
        Kernel.sleep(0.05)
        subtitle(gfx: gfx, ike: 0x00, zone: ZONE_H2, chars: genc(5))
        Kernel.sleep(0.05)
        subtitle(gfx: gfx, ike: 0x00, zone: ZONE_H3, chars: genc(5))
        Kernel.sleep(0.05)
        subtitle(gfx: gfx, ike: 0x01, zone: REFRESH, chars: '')
      end

      def index_macro(gfx: 0x60)
        INDEXES.each do |i|
          list(m1: gfx, m2: 0x00, m3: i, chars: geni(5))
          Kernel.sleep(0.05)
        end
        subtitle(gfx: gfx, ike: 0x01, zone: REFRESH, chars: '')
      end
    end
  end
end
