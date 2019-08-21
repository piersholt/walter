# frozen_string_literal: true

require_relative 'led/state'
require_relative 'led/modifiers'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            # Telephone::Emulated::Status
            module LED
              include State
              include Modifiers

              # API
              def leds_bit_field
                i = 0
                i |= red_bits    << LED_SHIFT_RED    if red?
                i |= yellow_bits << LED_SHIFT_YELLOW if yellow?
                i |= green_bits  << LED_SHIFT_GREEN  if green?
                i
              end
            end
          end
        end
      end
    end
  end
end
