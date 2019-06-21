# frozen_string_literal: true

module Wilhelm
  module Core
    class Interface
      # Stream properties
      class Stat < ::File::Stat
        CHARACTER_SPECIAL = 'characterSpecial'
        FILE = 'file'
        FIFO = 'fifo'

        def initialize(file_name)
          super(file_name)
        end

        def handler
          case ftype
          when CHARACTER_SPECIAL
            TTY::UART
          when FILE
            File::Log
          when FIFO
            File::Log
          else
            raise IOError, "Unrecognised file type: #{ftype}"
          end
        end
      end
    end
  end
end
