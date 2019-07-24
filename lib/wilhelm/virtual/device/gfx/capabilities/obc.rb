# frozen_string_literal: false

require_relative 'obc/average_speed'
require_relative 'obc/consumption'
require_relative 'obc/distance'
require_relative 'obc/limit'
require_relative 'obc/range'
require_relative 'obc/timer'

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          # On-board Computer interface controls
          module OnBoardComputer
            include AverageSpeed
            include Consumption
            include Distance
            include Limit
            include Range
            include Timer

            def pad_byte_array(byte_array, length)
              until byte_array.length == length
                byte_array.unshift(0)
              end
            end

            # Draw all OBC fields
            def obc?
              range?
              consumption_1?
              consumption_2?
              average_speed?
              limit?
              timer?
              distance?
            end
          end
        end
      end
    end
  end
end
