# frozen_string_literal: false

module Capabilities
  # Comment
  module GFX
    include Helpers

    def gfx(option = 0b0000_0010)
      config(arguments: { config: option })
    end
  end
end
