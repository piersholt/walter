# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::lamp
      class Lamp < Base
        include Wilhelm::Helpers::DataTools

        # @override
        def to_s
          "#{sn}\t" \
          "#{@byte1}"
        end

        def inspect
          "#{sn}\t" \
          "#{@byte1.inspect}"
        end
      end
    end
  end
end
