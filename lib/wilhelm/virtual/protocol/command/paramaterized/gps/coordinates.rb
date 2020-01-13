# frozen_string_literal: true

require_relative 'coordinates/coordinate'
require_relative 'coordinates/time'

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module GPS
          # Virtual::Command::GPS
          class Coordinates < Base
            Coordinates = Struct.new(:latitude, :longitude, :vertical)

            class_variable_set(:@@configured, true)
            attr_accessor(
              :signal,
              :lat_d,  :lat_m,  :lat_s,  :lat_sf,
              :long_d, :long_m, :long_s, :long_sf,
              :vertical,
              :hour, :minute, :second
            )

            include Wilhelm::Helpers::PositionalNotation
            include Coordinate
            include Time

            def initialize(id, props, **arguments)
              super
            end

            def to_s
              "#{sn}" \
              "\t#{signal}" \
              "\t#{format_coordinates}" \
              "\t#{format_time}\t(Now: #{::Time.now.utc})"
            end

            def coordinates
              @coordinates ||=
                Coordinates.new(
                  latitude, longitude, parse(vertical.calculated)
                )
            end

            def signal?
              case signal.ugly
              when :connected
                true
              when :disconnected
                false
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
