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
            attr_accessor(:hour, :minute, :day, :month, :year)

            include Wilhelm::Helpers::PositionalNotation

            # Epoch 0: 1980-01-06
            # Epoch 1: 1999-08-22
            # Epoch 2: 2019-04-07

            # 2^10 (1024) weeks
            GPS_EPOCH = (2**10) * (7 * 24 * 60 * 60)

            def initialize(id, props, **arguments)
              super
            end

            def to_s
              "#{sn}" \
              "\t#{time_object.iso8601}" \
              "\t#{(time_object + GPS_EPOCH).iso8601}"
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
              )
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
                format(TIME_MASK, 0)
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
