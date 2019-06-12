# frozen_string_literal: true

module Wilhelm::Virtual::Capabilities
  module MultiFunctionWheel
    # Comment
    module Buttons
      include Wilhelm::Virtual::API::MultiFunctionWheel
      include ButtonHelpers
      include Constants

      # 0x3B MFL-FUNC ---------------------------------------------------------
      def next
        press_and_release(method: :mfl_func_button,
                          to:      mode_target,
                          press:   NEXT_PRESS,
                          release: NEXT_RELEASE)
      end

      def previous
        press_and_release(method: :mfl_func_button,
                          to:      mode_target,
                          press:   PREV_PRESS,
                          release: PREV_RELEASE)
      end

      def tel
        press_and_release(method: :mfl_func_button,
                          to: :tel,
                          press: TEL_PRESS,
                          release: TEL_RELEASE)
      end

      def tel!
        mfl_func_button(to: :tel, action: RT_TEL_PRESS)
      end

      def rad!
        mfl_func_button(to: :tel, action: RT_RAD_PRESS)
      end

      # 0x32 MFL-VOL ----------------------------------------------------------

      def volume(mag)
        return false if mag > MAGNITUDE_MAX
        adjustment = mag.positive? ? (mag + VOLUME_UP) : mag.magnitude
        mfl_vol_button(to: :rad, adjustment: adjustment)
      end

      def volume_up(mag = MAGNITUDE_DEFAULT)
        adjustment = (mag + MAGNITUDE_OFFSET) + VOLUME_UP
        mfl_vol_button(to: :rad, adjustment: adjustment)
      end

      def volume_down(mag = MAGNITUDE_DEFAULT)
        adjustment = (mag + MAGNITUDE_OFFSET)
        mfl_vol_button(to: :rad, adjustment: adjustment)
      end
    end
  end
end
