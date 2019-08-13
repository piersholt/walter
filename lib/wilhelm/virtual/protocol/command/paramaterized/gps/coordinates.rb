# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module GPS
          # Virtual::Command::GPS
          class Coordinates < Base
            include Wilhelm::Helpers::PositionalNotation

            TIME_MASK   = '%2.2i'
            MINUTE_MASK = '%2.2i'
            SECOND_MASK = '%2.2i'

            MINUS   = "\u2212"
            DEGREES = "\u00b0"
            MINUTES = "\u2032"
            SECONDS = "\u2033"
            DECIMAL = '.'

            def initialize(id, props, **arguments)
              super
            end

            def to_s
              "#{sn}\t#{format_coordinates}"
            end

            # https://en.wikipedia.org/wiki/ISO_6709
            # 50°03′46.461″S 125°48′26.533″E 978.90m
            # DDD° MM' SS.S"
            def format_coordinates
              lat = format_coordinate(
                latitude(:degrees),
                latitude(:minutes),
                latitude(:seconds),
                latitude(:fraction)
              )
              long = format_coordinate(
                longitude(:degrees),
                longitude(:minutes),
                longitude(:seconds),
                longitude(:fraction)
              )

              "#{lat}\t#{long}"
            end

            def format_coordinate(degrees, minutes, seconds, fraction)
              "#{degrees}#{DEGREES}" \
              "#{minutes}#{MINUTES}" \
              "#{seconds}#{DECIMAL}#{fraction}#{SECONDS}"
            end

            def latitude(element)
              case element
              when :degrees
                parse(*lat_d.calculated)
              when :minutes
                format(MINUTE_MASK, parse(*lat_m.calculated))
              when :seconds
                format(SECOND_MASK, parse(*lat_s.calculated))
              when :fraction
                format(SECOND_MASK, parse(*lat_sf.calculated))
              end
            end

            def longitude(element)
              case element
              when :degrees
                parse(*long_d.calculated)
              when :minutes
                format(MINUTE_MASK, parse(*long_m.calculated))
              when :seconds
                format(SECOND_MASK, parse(*long_s.calculated))
              when :fraction
                format(SECOND_MASK, parse(*long_sf.calculated))
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
