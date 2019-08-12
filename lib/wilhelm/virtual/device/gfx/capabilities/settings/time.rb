# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module Settings
            # Settings::Time
            module Time
              include API
              include Constants

              PM_OFFSET = 0b1000_0000

              # Time 0x01 [Request]
              def time?
                obc_bool(field: FIELD_TIME, control: CONTROL_REQUEST)
              end

              alias t? time?

              # Time 0x01 Input
              def input_time(hour = hour?, minute = min?, seconds = sec?)
                return false unless valid_time?(hour, minute)
                hour = to_twelve_hour_time(hour)
                obc_var(field: FIELD_TIME, input: [hour, minute, seconds])
              end

              alias time! input_time

              private

              def validate_time(hour, minute)
                return true if valid_time?(hour, minute)
                raise(
                  ArgumentError,
                  "Invalid time! Hour: #{hour}, Minute: #{minute}"
                )
              end

              def valid_time?(hour, minute)
                return false unless integers?(hour, minute)
                return false if negative?(hour, minute)
                return false unless valid_hour?(hour) && valid_minute?(minute)
                true
              end

              def valid_hour?(hour)
                (0..23).cover?(hour)
              end

              def valid_minute?(minute)
                (0..59).cover?(minute)
              end

              def hour?
                ::Time.now.hour
              end

              def min?
                ::Time.now.min
              end

              def sec?
                ::Time.now.sec
              end

              def to_twelve_hour_time(hour)
                return hour unless hour > 12
                hour -= 12
                hour + PM_OFFSET
              end
            end
          end
        end
      end
    end
  end
end
