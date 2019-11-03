# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module GPS
          class Coordinates < Base
            # Virtual::Command::GPS::Coordinate
            module Coordinate
              Latitude   = Struct.new(:degrees, :minutes, :seconds, :fraction)
              Longtitude = Struct.new(:degrees, :minutes, :seconds, :fraction)

              def latitude
                @latitude ||=
                  Latitude.new(
                    platitude(:degrees),
                    platitude(:minutes),
                    platitude(:seconds),
                    platitude(:fraction)
                  )
              end

              def longitude
                @longitude ||=
                  Longtitude.new(
                    plongitude(:degrees),
                    plongitude(:minutes),
                    plongitude(:seconds),
                    plongitude(:fraction)
                  )
              end

              # https://en.wikipedia.org/wiki/ISO_6709
              # 50°03′46.461″S 125°48′26.533″E 978.90m
              # DDD° MM' SS.S"
              def format_coordinates
                lat = format_coordinate(
                  flatitude(:degrees),
                  flatitude(:minutes),
                  flatitude(:seconds),
                  flatitude(:fraction)
                )
                long = format_coordinate(
                  flongitude(:degrees),
                  flongitude(:minutes),
                  flongitude(:seconds),
                  flongitude(:fraction)
                )

                "#{lat}\t#{long}"
              end

              def format_coordinate(degrees, minutes, seconds, fraction)
                "#{degrees}#{DEGREES}" \
                "#{minutes}#{MINUTES}" \
                "#{seconds}#{DECIMAL}#{fraction}#{SECONDS}"
              end

              def platitude(element)
                case element
                when :degrees
                  parse(*lat_d.calculated)
                when :minutes
                  parse(*lat_m.calculated)
                when :seconds
                  parse(*lat_s.calculated)
                when :fraction
                  parse(*lat_sf.calculated)
                end
              end

              def plongitude(element)
                case element
                when :degrees
                  parse(*long_d.calculated)
                when :minutes
                  parse(*long_m.calculated)
                when :seconds
                  parse(*long_s.calculated)
                when :fraction
                  parse(*long_sf.calculated)
                end
              end

              def flatitude(element)
                case element
                when :degrees
                  platitude(:degrees)
                when :minutes
                  format(MINUTE_MASK, platitude(:minutes))
                when :seconds
                  format(SECOND_MASK, platitude(:seconds))
                when :fraction
                  format(SECOND_MASK, platitude(:fraction))
                end
              end

              def flongitude(element)
                case element
                when :degrees
                  plongitude(:degrees)
                when :minutes
                  format(MINUTE_MASK, plongitude(:minutes))
                when :seconds
                  format(SECOND_MASK, plongitude(:seconds))
                when :fraction
                  format(SECOND_MASK, plongitude(:fraction))
                end
              end
            end
          end
        end
      end
    end
  end
end
