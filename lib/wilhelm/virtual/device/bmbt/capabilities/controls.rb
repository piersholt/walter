# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module Capabilities
          # BMBT::Capabilities::Controls
          module Controls
            include API
            include Constants
            include Wilhelm::Virtual::Device::Helpers::Parse
            include Wilhelm::Virtual::Device::Helpers::Data

            def power
              press_and_release(
                press:    POWER_PRESS,
                release:  POWER_RELEASE
              )
            end

            def mode_next
              press_and_release(
                press:    MODE_NEXT_PRESS,
                release:  MODE_NEXT_RELEASE
              )
            end

            alias mode mode_next

            def next
              press_and_release(
                press:    NEXT_PRESS,
                release:  NEXT_RELEASE
              )
            end

            def menu
              press_and_release(
                press:    MENU_PRESS,
                release:  MENU_RELEASE
              )
            end

            def confirm
              press_and_release(
                press:    CONFIRM_PRESS,
                release:  CONFIRM_RELEASE
              )
            end

            def tone
              press_and_release(
                press:    TONE_PRESS,
                release:  TONE_RELEASE
              )
            end

            def select
              press_and_release(
                press:    SELECT_PRESS,
                release:  SELECT_RELEASE
              )
            end

            def rds
              press_and_release(
                press:    RDS_PRESS,
                release:  RDS_RELEASE
              )
            end

            def tp
              press_and_release(
                press: TP_PRESS,
                release: TP_RELEASE
              )
            end

            def overlay
              press_and_release(
                press:    OVERLAY_PRESS,
                release:  OVERLAY_RELEASE
              )
            end

            def eject
              press_and_release(
                press:    EJECT_PRESS,
                release:  EJECT_RELEASE
              )
            end

            alias radio_mode overlay

            private

            def press_and_release(press:, release:)
              bmbt_btn_a(to: :rad, action: integers_input(press))
              Kernel.sleep(0.05)
              bmbt_btn_a(to: :rad, action: integers_input(release))
            end
          end
        end
      end
    end
  end
end
