# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Device
        # Virtual::Constants::Device::Groups
        module Groups
          include Aliases

          MEDIA = [
            CDC, CD, RAD, DSP, GFX, TV, BMBT
          ].freeze

          CD_PLAYER = [
            CDC, CD, RAD, GFX, BMBT, MFL
          ].freeze

          TELEPHONE = [
            TEL, IKE, RAD, GFX, ANZV, BMBT
          ].freeze

          NAVIGATION = [
            NAV_JP, NAV
          ].freeze

          BROADCAST = [
            GLO_H, GLO_L
          ].freeze
        end
      end
    end
  end
end
