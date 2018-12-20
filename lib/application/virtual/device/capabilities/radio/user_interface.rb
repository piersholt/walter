# frozen_string_literal: true

module Capabilities
  module Radio
    # BMBT Interface Control
    module UserInterface
      include API::Radio

      def home
        interface(arguments: { state: 0b0000_0001 })
      end

      def overlay(option = 0b0000_1110)
        interface(arguments: { state: option })
      end

      def manual
        selection(mode: 0x40)
      end

      def eq(band = :eq)
        case band
        when :bass
          selection(mode: 0xc0)
        when :treble
          selection(mode: 0xd0)
        when :fader
          selection(mode: 0xe0)
        when :balance
          selection(mode: 0xf0)
        when :eq
          selection(mode: 0x80)
        end
      end
    end
  end
end
