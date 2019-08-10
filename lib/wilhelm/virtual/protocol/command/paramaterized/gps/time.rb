# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module GPS
          # Virtual::Command::UTC
          class Time < Base
            include Wilhelm::Helpers::PositionalNotation

            DATE_MASK = '%2.2i'
            TIME_MASK = '%2.2i'

            COMBINATION_DELIMITER = 'T'
            DATE_DELIMITER = '-'
            TIME_DELIMITER = ':'

            def initialize(id, props, **arguments)
              super
            end

            def to_s
              format_date_time
            end

            # https://en.wikipedia.org/wiki/ISO_8601
            # YYYY-MM-DD
            # hh:mm:ss
            # <date>T<time>
            # 2007-04-05T14:30
            def format_date_time
              d = format_date(date(:year), date(:month), date(:day))
              t = format_time(time(:hour), time(:minute), time(:second))

              "#{d}#{COMBINATION_DELIMITER}#{t}"
            end

            def format_date(year, month, day)
              "#{year}#{DATE_DELIMITER}" \
              "#{month}#{DATE_DELIMITER}" \
              "#{day}"
            end

            def format_time(hour, minute, second)
              "#{hour}#{TIME_DELIMITER}" \
              "#{minute}#{TIME_DELIMITER}" \
              "#{second}" \
            end

            def date(element)
              case element
              when :year
                format(DATE_MASK, parse(*year.calculated))
              when :month
                format(DATE_MASK, parse(*month.calculated))
              when :day
                format(DATE_MASK, parse(*day.calculated))
              end
            end

            def time(element)
              case element
              when :hour
                format(TIME_MASK, parse(*hour.calculated))
              when :minute
                format(TIME_MASK, parse(*minute.calculated))
              when :second
                format(TIME_MASK, parse(*second.calculated))
              end
            end

            def parse(*digits)
              digits = base_16_digits(*digits)
              number = parse_base_10_digits(*digits)
              return number if number
              0
            end
          end
        end
      end
    end
  end
end
