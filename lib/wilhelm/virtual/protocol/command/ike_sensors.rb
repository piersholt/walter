# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::IKESensors
      class IKESensors < Base
        include Wilhelm::Helpers::DataTools

        def to_s
          "#{sn}\t" \
          "#{@bit_array_1}\t" \
          "#{@bit_array_2}\t" \
          "#{@bit_array_3}"
        end

        def inspect
          "<#{PROC} #{@bit_array_1.inspect} " \
          "#{@bit_array_2.inspect} " \
          "#{@bit_array_3.inspect}"
        end
      end
    end
  end
end
