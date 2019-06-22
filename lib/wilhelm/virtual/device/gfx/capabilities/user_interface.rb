# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # Comment
          module UserInterface
            include API

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
    end
  end
end
