# frozen_string_literal: true

module Capabilities
  # Comment
  module Diagnostics
    include Helpers
    include API::Diagnostics
    include Windows
    include Seats
    include Lighting

    def attempt(string)
      mapped_integers = string.split(' ').map { |i| i.to_i(16) }
      arguments = array(mapped_integers)
      LOGGER.info(name) { arguments }

      vehicle_control(to: :gm3, arguments: arguments)
    end
  end
end
