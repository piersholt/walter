# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module API
          # Radio/GT interface control commands
          module Radio
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x46 MENU-GT
            def config(from: :gt, to: :rad, arguments:)
              try(from, to, MENU_GT, arguments)
            end

            # 0x4E SND-SRC
            def sound_source(from: :gt, to: :rad, arguments:)
              try(from, to, SRC_SND, arguments)
            end

            # # 0x4F SRC-GT
            # # @param action
            # # @param nav
            # def sound_source(from: :tv, to: :bmbt, arguments:)
            #   try(from, to, SRC_GT, arguments)
            # end
          end
        end
      end
    end
  end
end
