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

      private

      def valid_time?(hour, minute)
        return false unless hour.is_a?(Numeric) && minute.is_a?(Numeric)
        return false if hour > 23 || minute > 59
        return false if hour.negative? || minute.negative?
        true
      end

      def valid_date?(day, month, year)
        return false unless [day, month, year].all? { |i| i.is_a?(Numeric) }
        return false if day.negative? || month.negative? || year.negative?
        true
      end
    end
  end
end
