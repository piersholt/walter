require 'thread'

class Channel
  # An extension of a Queue to support multi shifts, and unshifting
  # NOTE this should not handle unshift.... argh.. well.. unshift is framer behaviour..
  # but it's still capsulated with framer.. the actual behaviour of unshift is generic...
  class IOBuffer < Queue
    def initialize
      super
      @unshift_buffer = []
    end

    # Not existing client implemention matches Array#unshift, requirin multiple
    # arguments to be splatted, i.e. buffer.unshift(*my_array)
    def unshift(*objects)
      LOGGER.debug("#{self.class}#unshift(#{objects.size})")
      @unshift_buffer.unshift(*objects)
    end

    # def push(args)
    #   super.push(args)
    # end

    def shift(number_of_bytes = 1)
      # binding.pry
      LOGGER.debug("#{self.class}#shift(#{number_of_bytes})")
      raise ::ArgumentError, 'IOBuffer does not support single object shift' if
        number_of_bytes <= 1

      shift_result = []

      # Empty unshift buffer before reading IO
      take_unshifted_bytes(shift_result, number_of_bytes)

      Array.new(number_of_bytes - shift_result.size).each do |_|
        read_byte = pop
        shift_result.push(read_byte)
      end

      shift_result
    end

    private

    def take_unshifted_bytes(shift_result, number_of_bytes)
      LOGGER.debug("#{self.class}#take_unshifted_bytes(#{number_of_bytes})")
      LOGGER.debug("Unshift buffer size = #{@unshift_buffer.size}")
      required_bytes = number_of_bytes
      return false if @unshift_buffer.empty?
      until @unshift_buffer.empty? || required_bytes.zero?
        unshifted_byte = @unshift_buffer.shift
        shift_result.push(unshifted_byte)
        required_bytes -= 1
      end
      LOGGER.debug("Unshifted bytes: #{shift_result.size}")
      true
    end
  end
end
