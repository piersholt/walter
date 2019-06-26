# frozen_string_literal: true

require_relative 'api/lcd'
require_relative 'api/obc'

module Wilhelm
  module Virtual
    class Device
      module GFX
        # Comment
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          # MENU/USER INTERFACE

          # 0x46 MENU-GFX
          def config(from: :gfx, to: :rad, arguments:)
            try(from, to, MENU_GFX, arguments)
          end

          # 0x4E SND-SRC
          def sound_source(from: :gfx, to: :rad, arguments:)
            try(from, to, SRC_SND, arguments)
          end

          # 0x31 TEL_DATA
          def user_input(from: :gfx, to: :rad, **arguments)
            try(from, to, TEL_DATA, arguments)
          end

          # # 0x4F SRC-GFX
          # # @param action
          # # @param nav
          # def sound_source(from: :tv, to: :bmbt, arguments:)
          #   try(from, to, SRC_GFX, arguments)
          # end
        end
      end
    end
  end
end
