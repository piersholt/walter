require 'bit_array'

class Commands
  class IKESensors < BaseCommand
    include DataTools
    def initialize(id, props)
      super(id, props)
    end

    def bytes
      { }
    end

    # ---- Core ---- #

    # @override
    def to_s
      str_buffer = formatted
      str_buffer
    end

    def inspect
      str_buffer = formatted
      str_buffer
    end

    def formatted
      "#{sn}\t#{bit_array(@byte1)}\t#{bit_array(@byte2)}\t#{bit_array(@byte3)}"
    end

    def bit_array(integer)
      BitArray.from_i(integer)
    end
  end
end
