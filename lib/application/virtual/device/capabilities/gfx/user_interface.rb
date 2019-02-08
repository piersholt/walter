# frozen_string_literal: false

module Capabilities
  module GFX
    # BMBT Interface Control
    module UserControls
      include API::GFX

      def select(i, l = 0x60)
        input(layout: l, index: i)
      end

      def fm!(l = 0x60)
        input(layout: l, index: 6)
      end

      def am!(l = 0x60)
        input(layout: l, index: 7)
      end

      def sc!(l = 0x60)
        input(layout: l, index: 8)
      end

      def cd!(l = 0x60)
        input(layout: l, index: 9)
      end

      def tape!(l = 0x60)
        input(layout: l, index: 10)
      end

      def empty!(l = 0x60)
        input(layout: l, index: 11)
      end

      # " 1 ☐ 2 ☐ 3 ☐ 4 ☐ 5 ☐ 6 "
      # "FM☐AM☐SC☐CD☐TAPE☐   "

      def input(layout: 0x60, index: 11)
        user_input(source: layout, function: 0x00, action: index)
        Kernel.sleep(0.05)
        user_input(source: layout, function: 0x00, action: (index + 0x40))
      end
    end

    module UserInterface
      include API::GFX

      # Shortcuts
      def main
        config(arguments: { config: 0b0000_0001 })
      end

      def overlay
        config(arguments: { config: 0b0000_0011 })
      end


      # DIRECT API ---------

      # def test_gfx(option = 0b0000_0010)
      #   config(arguments: { config: option })
      # end

      def source(source = 0x10, b2 = 0x00)
        sound_source(arguments: { source: source, b2: b2 })
      end

      # def go
      #   (0x00..0xFF).each do |i|
      #     gfx(i)
      #     Kernel.sleep(3)
      #   end
      # end
    end
  end
end
