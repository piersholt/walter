# frozen_string_literal: true

module Capabilities
  module OnBoardMonitor
    # Comment
    module UserControls
      include API::OnBoardMonitor
      include Constants

      def power
        press_and_release(press: POWER_PRESS, release: POWER_RELEASE)
      end

      def mode
        press_and_release(press: MODE_NEXT_PRESS, release: MODE_NEXT_RELEASE)
      end

      def next
        press_and_release(press: NEXT_PRESS, release: NEXT_RELEASE)
      end

      def menu
        press_and_release(press: MENU_PRESS, release: MENU_RELEASE)
      end

      def confirm
        press_and_release(press: CONFIRM_PRESS, release: CONFIRM_RELEASE)
      end

      def tone
        press_and_release(press: TONE_PRESS, release: TONE_RELEASE)
      end

      def rds
        press_and_release(press: RDS_PRESS, release: RDS_RELEASE)
      end

      def tp
        press_and_release(press: TP_PRESS, release: TP_RELEASE)
      end

      private

      def press_and_release(press:, release:)
        button(to: :rad, arguments: integers_input(press))
        Kernel.sleep(0.05)
        button(to: :rad, arguments: integers_input(release))
      end
    end
  end
end
