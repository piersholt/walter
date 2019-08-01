# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            # Device::Telephone::Emulated::State::Models
            module Model
              include Wilhelm::Helpers::Stateful
              include Constants

              DEFAULT_STATE = {
                STATE_STATUS => {
                  STATUS_BIT_1    => STATUS_DEFAULT,
                  STATUS_BIT_2    => STATUS_DEFAULT,
                  STATUS_ACTIVE   => STATUS_NO,
                  STATUS_POWER    => STATUS_OFF,
                  STATUS_DISPLAY  => STATUS_DEFAULT,
                  STATUS_INCOMING => STATUS_NO,
                  STATUS_MENU     => STATUS_DEFAULT,
                  STATUS_HFS      => STATUS_NO
                },
                STATE_LEDS => {
                  LED_RED    => LED_OFF,
                  LED_YELLOW => LED_OFF,
                  LED_GREEN  => LED_OFF
                }
              }.freeze

              def default_state
                DEFAULT_STATE.dup
              end
            end
          end
        end
      end
    end
  end
end
