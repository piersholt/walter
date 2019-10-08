# frozen_string_literal: true

require_relative 'state/constants'
require_relative 'state/model'
require_relative 'state/backlight'

module Wilhelm
  module Virtual
    class Device
      module LCM
        class Augmented < Device::Augmented
          # LCM::Augmented::State
          module State
            include Model
            include Backlight

            # LogActually.is_all_around(:lcm)
            # LogActually.lcm.d

            # def logger
            #   LogActually.lcm
            # end
          end
        end
      end
    end
  end
end
