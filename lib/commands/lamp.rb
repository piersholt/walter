require 'bit_array'

class Commands
  class Lamp < BaseCommand
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
      "#{sn}\t#{bit_array(@byte1)}\t#{bit_array(@byte2)}\t#{bit_array(@byte3)}\t#{bit_array(@byte4)}"
    end

    def bit_array(integer)
      BitArray.from_i(integer)
    end
  end
end

# 0100 0011	0000 0000	0000 0100	0000 0000 RIGHT
# 0010 0011	0000 0000	0000 0100	0000 0000


# nothing happens on reverse
# nothing happens on brake

# check brake lights
# right out
# 0000 0000 /	0000 0000	/ 0000 0010	/ 0000 0001
# left out
# 0000 0000 /	0000 0000	/ 0000 0010	/ 0000 0010
