# frozen_string_literal: true

module Capabilities
  # Comment
  module Radio
    include Helpers
    include API::Radio

    # CD Changer

    def next!
      cd_changer_request(arguments: { control: 0x04, mode: 0x00 })
    end

    def play!
      cd_changer_request(arguments: { control: 0x03, mode: 0x00 })
    end

    def stop!
      cd_changer_request(arguments: { control: 0x01, mode: 0x00 })
    end

    # MENU

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
