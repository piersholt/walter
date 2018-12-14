# frozen_string_literal: true

module Capabilities
  # Comment
  module Diagnostics
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

    # private

    def integers(*arguments)
      bytes(arguments)
    end

    def array(arguments)
      bytes(arguments)
    end

    def bytes(arguments)
      array_of_bytes = arguments.map { |int| Byte.new(:decimal, int) }
      Bytes.new(array_of_bytes)
    end
  end
end
