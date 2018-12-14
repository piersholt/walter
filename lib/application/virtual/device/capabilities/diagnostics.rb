# frozen_string_literal: true

module Capabilities
  # Comment
  module Diagnostics
    include API::Diagnostics
    include Windows

    # def get(constant_name)
    #   result = const_get(":#{constant_name}")
    #   raise ArgumentError, "nothing matches: #{constant_name}"
    #   LOGGER.info(name) { result }
    #   result.split(' ').map(&:to_i)
    # end

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

    def attempt(string)
      mapped_integers = string.split(' ').map { |i| i.to_i(16) }
      # .map {|i| i.to_i(16)}
      arguments = array(mapped_integers)
      LOGGER.info(name) { arguments }

      vehicle_control(to: :gm3, arguments: arguments)
    end

    # def activate(*arguments)
    #   bytes(arguments)
    # end

    def seat_backward
      arguments = [0x05, 0x01, 0x01]
      array_of_bytes = arguments.map { |int| Byte.new(:decimal, int) }
      bytes = Bytes.new(array_of_bytes)

      vehicle_control(to: :gm3, arguments: bytes)
    end

    def seat_forward
      arguments = [0x05, 0x00, 0x01]
      array_of_bytes = arguments.map { |int| Byte.new(:decimal, int) }
      bytes = Bytes.new(array_of_bytes)

      vehicle_control(to: :gm3, arguments: bytes)
    end

    def hi(to)
      hello(to: to)
    end

    def hi!(to_id)
      hello(to: to_id, raw: true)
    end
  end
end

# DataLink::LogicalLinkLayer::Multiplexer#mtultiplex
