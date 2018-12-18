# frozen_string_literal: true

module Capabilities
  # Comment
  module OnBoardMonitor
    include API::OnBoardMonitor

    POWER_PRESS   = 0x06
    POWER_HOLD    = 0x46
    POWER_RELEASE = 0x86

    def power
      press_and_release(press: POWER_PRESS, release: POWER_RELEASE)
    end

    MODE_NEXT_PRESS   = 0x33
    MODE_NEXT_HOLD    = 0x73
    MODE_NEXT_RELEASE = 0xB3

    def mode
      press_and_release(press: MODE_NEXT_PRESS, release: MODE_NEXT_RELEASE)
    end

    NEXT_PRESS   = 0x00
    NEXT_HOLD    = 0x40
    NEXT_RELEASE = 0x80

    def next
      press_and_release(press: NEXT_PRESS, release: NEXT_RELEASE)
    end

    MENU_PRESS   = 0x34
    MENU_HOLD    = 0x74
    MENU_RELEASE = 0xB4

    def menu
      press_and_release(press: MENU_PRESS, release: MENU_RELEASE)
    end

    CONFIRM_PRESS   = 0x05
    CONFIRM_HOLD    = 0x45
    CONFIRM_RELEASE = 0x85

    def confirm
      press_and_release(press: CONFIRM_PRESS, release: CONFIRM_RELEASE)
    end

    private

    def press_and_release(press:, release:)
      button(to: :rad, arguments: integers_input(press))
      Kernel.sleep(0.05)
      button(to: :rad, arguments: integers_input(release))
    end
  end
end
