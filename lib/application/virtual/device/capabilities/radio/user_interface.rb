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

      # TODO shoud be GFX
      def gfx(option = 0b0000_0010)
        config(arguments: { config: option })
      end
    end
  end
end
