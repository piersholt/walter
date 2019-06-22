# frozen_string_literal: true

require_relative 'capabilities/gm'
require_relative 'capabilities/lcm'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # Comment
        module Capabilities
          include Helpers
          include API
          include Windows
          include Seats
          include Lighting

          def attempt(string)
            mapped_integers = string.split(' ').map { |i| i.to_i(16) }
            arguments = array(mapped_integers)
            LOGGER.info(name) { arguments }

            vehicle_control(to: :gm3, arguments: arguments)
          end

          # MODULE SERVICE MODE

          def bmbt_service_mode(string, from = :bmbt, to = :gfx)
            mapped_integers = string.split(' ').map { |i| i.to_i(16) }
            arguments = array(mapped_integers)
            service_mode_reply(from: from, to: to, arguments: arguments)
          end
        end
      end
    end
  end
end
