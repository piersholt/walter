# require 'application/commands/parameter/bit_array'

class Wilhelm::Core::Command
  class Lamp < BaseCommand
    include Wilhelm::Helpers::DataTools

    def initialize(id, props)
      super(id, props)
    end

    # ---- Core ---- #

    # @override
    def to_s
      "#{sn}\t#{@byte1}"
    end

    def inspect
      "#{sn}\t#{(@byte1.inspect)}"
    end

    def raw

      # \t#{bit_array(@byte2)}\t#{bit_array(@byte3)}\t#{bit_array(@byte4)}
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
