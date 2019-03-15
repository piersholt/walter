# frozen_string_literal: true

module Capabilities
  module Radio
    # BMBT Interface Control
    module UserInterface
      include API::Radio

      def main
        menu_rad(arguments: { state: 0b0000_0001 })
      end

      def menu_rad!(option = 0b0000_1110)
        menu_rad(arguments: { state: option })
      end

      def hide_panel
        menu_rad(arguments: { state: 0b0000_0010 })
      end

      def hide_tone_select
        menu_rad(arguments: { state: 0b0000_1100 })
      end

      def hide_select
        menu_rad(arguments: { state: 0b0000_0100 })
      end

      def hide_tone
        menu_rad(arguments: { state: 0b0000_1000 })
      end

      def hide_all
        menu_rad(arguments: { state: 0b0000_1110 })
      end

      def eq(band = :eq)
        case band
        when :bass
          rad_alt(mode: 0xc0)
        when :treble
          rad_alt(mode: 0xd0)
        when :fader
          rad_alt(mode: 0xe0)
        when :balance
          rad_alt(mode: 0xf0)
        when :eq
          rad_alt(mode: 0x80)
        when :eq2
          rad_alt(mode: 0x80)
        when :eq3
          rad_alt(mode: 0x80)
        when :eq4
          rad_alt(mode: 0x80)
        end
      end
    end
  end
end
