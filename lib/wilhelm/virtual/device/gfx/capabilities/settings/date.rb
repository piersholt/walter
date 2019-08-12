# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module Settings
            # Settings::Date
            module Date
              include API
              include Constants

              CENTURY = 100

              # Date 0x02 [Request]
              def date?
                obc_bool(field: FIELD_DATE, control: CONTROL_REQUEST)
              end

              alias d? date?

              # Date 0x02 Input
              # @note IKE default century of 2000 for (00..92)
              # @note IKE default century of 1900 for (93..99)
              def input_date(day = day?, month = month?, year = year?)
                validate_date(day, month, year)
                year = to_short_year(year)
                obc_var(field: FIELD_DATE, input: [day, month, year])
              end

              alias date! input_date

              private

              def validate_date(day, month, year)
                return true if valid_date?(day, month, year)
                raise(
                  ArgumentError,
                  "Invalid date! Day: #{day}, Month: #{month}, Year: #{year}"
                )
              end

              def valid_date?(day, month, year)
                return false unless integers?(day, month, year)
                return false if negative?(day, month, year)
                true
              end

              def year?
                ::Time.now.year
              end

              def month?
                ::Time.now.month
              end

              def day?
                ::Time.now.day
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
