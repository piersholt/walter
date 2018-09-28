require 'command/parameter/bit_array'

class Command
  class IKESensors < BaseCommand
    include DataTools
    PROC = 'IKESensors'
    def initialize(id, props)
      super(id, props)
    end

    def to_s
      "#{sn}\t#{@bit_array_1}\t#{@bit_array_2}\t#{@bit_array_3}"
    end

    def inspect
      "<#{PROC} #{(@bit_array_1.inspect)} #{(@bit_array_2.inspect)} #{(@bit_array_3.inspect)}"
    end
  end
end
