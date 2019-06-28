# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module Settings
            # Settings: Date and Time
            module DateTime
              include API
              include Constants

              CENTURY = 100
              PM_OFFSET = 0b1000_0000

              def input_time(hour = hour?, minute = min?, seconds = sec?)
                return false unless valid_time?(hour, minute)
                hour = to_twelve_hour_time(hour)
                obc_var(b1: FIELD_TIME, b2: hour, b3: minute, b4: seconds)
              end

              alias time! input_time

              # @note IKE default century of 2000 for (00..92)
              # @note IKE default century of 1900 for (93..99)
              def input_date(day = day?, month = month?, year = year?)
                return false unless valid_date?(day, month, year)
                year = to_short_year(year)
                obc_var(b1: FIELD_DATE, b2: day, b3: month, b4: year)
              end

              alias date! input_date

              private

              def valid_time?(hour, minute)
                return false unless integers?(hour, minute)
                return false if negative?(hour, minute)
                return false unless valid_hour?(hour) && valid_minute?(minute)
                true
              end

              def valid_date?(day, month, year)
                return false unless integers?(day, month, year)
                return false if negative?(day, month, year)
                true
              end

              def integers?(*integers)
                integers.all? { |i| i.is_a?(Integer) }
              end

              def valid_hour?(hour)
                (0..23).cover?(hour)
              end

              def valid_minute?(minute)
                (0..59).cover?(minute)
              end

              def negative?(*integers)
                integers.any?(&:negative?)
              end

              def year?
                Time.now.year
              end

              def month?
                Time.now.month
              end

              def day?
                Time.now.day
              end

              def hour?
                Time.now.hour
              end

              def min?
                Time.now.min
              end

              def sec?
                Time.now.sec
              end

              def to_twelve_hour_time(hour)
                return hour unless hour > 12
                hour -= 12
                hour + PM_OFFSET
              end

              def to_short_year(year)
                year - year.div(CENTURY) * CENTURY
              end
            end
          end
        end
      end
    end
  end
end
