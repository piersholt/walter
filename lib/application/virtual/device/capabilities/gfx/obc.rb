# frozen_string_literal: false

module Capabilities
  module GFX
    # BMBT Interface Control
    module OBC
      include API::OBC
      include Constants
      # include DataTools

      def set_time(hour = Time.now.hour, minute = Time.now.min)
        return false unless valid_time?(hour, minute)
        if hour > 12
          hour = hour - 12
          hour = hour + 0b1000_0000
        end
        obc_config(b1: SET_TIME, b2: hour, b3: minute, b4: 0)
      end

      def set_date(day = Time.now.day, month = Time.now.month, year = Time.now.year)
        return false unless valid_date?(day, month, year)
        obc_config(b1: SET_DATE, b2: day, b3: month, b4: year)
      end

      alias time! set_time
      alias date! set_date

      # gfx	ike	OBC-CONFIG	b1: 0x07 (Distance) / b2: 00 (b2: "0") / b3: 0x07 (b3: "7") / b4:  (b4: "")
      def set_distance(distance)
        return false unless valid_distance?(distance)
        obc_config(b1: SET_DISTANCE, b2: 0, b3: distance, b4: 0)
      end

      def set_code(four_digit_integer)
        return false unless valid_code?(four_digit_integer)
        hex_string = Kernel.format("%0.4x", four_digit_integer)
        b2 = hex_string[0,2].hex
        b3 = hex_string[2,2].hex
        obc_config(b1: SET_CODE, b2: b2 , b3: b3, b4: 0)
      end

      def set_something(property, x = 5, y = 5, z = 5)
        obc_config(b1: property, b2: x , b3: y, b4: z)
      end

      # OBC_CTL ----------------------------------------
      def aux(control = 0b0000_0000, unconfirmed = 0b0000_0000)
        obc_ctl(control: control, unconfirmed: unconfirmed)
      end

      private

      def valid_code?(four_digit_integer)
        return false unless four_digit_integer.is_a?(Integer)
        return false if four_digit_integer > 9999
        return false if four_digit_integer.negative?
        true
      end

      def valid_distance?(distance)
        return false unless distance.is_a?(Integer)
        # You need to deal with b2 if you want larger distance
        return false if distance > 255
        return false if distance.negative?
        true
      end

      def valid_time?(hour, minute)
        return false unless hour.is_a?(Integer) && minute.is_a?(Integer)
        return false if hour > 23 || minute > 59
        return false if hour.negative? || minute.negative?
        true
      end

      def valid_date?(day, month, year)
        return false unless [day, month, year].all? { |i| i.is_a?(Integer) }
        return false if day.negative? || month.negative? || year.negative?
        true
      end
    end
  end
end
