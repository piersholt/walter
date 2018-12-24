# frozen_string_literal: false

module Capabilities
  # Comment
  module GFX
    include API::GFX
    include Helpers

    def home
      config(arguments: { config: 0b0000_0001 })
    end

    def test_gfx(option = 0b0000_0010)
      config(arguments: { config: option })
    end

    def go
      (0x00..0xFF).each do |i|
        gfx(i)
        Kernel.sleep(3)
      end
    end
  end
end
