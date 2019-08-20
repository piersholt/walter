# frozen_string_literal: true

require 'time'

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module GPS
          # Virtual::Command::UTC
          class Time < Base
            class_variable_set(:@@configured, true)
            attr_accessor(:tz, :hour, :minute, :day, :second, :month, :year)

            include Wilhelm::Helpers::PositionalNotation

            DATE_MASK = '%2.2i'
            TIME_MASK = '%2.2i'

            COMBINATION_DELIMITER = 'T'
            DATE_DELIMITER = '-'
            TIME_DELIMITER = ':'

            GPS_EPOCH = 2**10 * 7 * 24 * 60 * 60

            def initialize(id, props, **arguments)
              super
            end

            def to_s
              "#{sn}\t#{time_object.iso8601}\t(#{::Time.now.utc})"
            end

            # https://en.wikipedia.org/wiki/ISO_8601
            # YYYY-MM-DD
            # hh:mm:ss
            # <date>T<time>
            # 2007-04-05T14:30
            # def format_date_time
            #   d = format_date(date(:year), date(:month), date(:day))
            #   t = format_time(time(:hour), time(:minute), time(:second))
            #
            #   "#{d}#{COMBINATION_DELIMITER}#{t}"
            # end

            def time_object
              @time_object ||= create_time
            end

            def create_time
              ::Time.local(
                date(:year),
                date(:month),
                date(:day),
                time(:hour),
                time(:minute),
                time(:second)
              ) + GPS_EPOCH
            end

            # def format_date(year, month, day)
            #   "#{year}#{DATE_DELIMITER}" \
            #   "#{month}#{DATE_DELIMITER}" \
            #   "#{day}"
            # end

            # def format_time(hour, minute, second)
            #   "#{hour}#{TIME_DELIMITER}" \
            #   "#{minute}#{TIME_DELIMITER}" \
            #   "#{second}" \
            # end

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
