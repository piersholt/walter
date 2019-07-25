# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Duration
      class Duration
        MILLISECOND = 1000
        SECOND = MILLISECOND * 60
        MINUTE = SECOND * 60
        HOUR = MINUTE * 60

        UNITS = [MILLISECOND, SECOND, MINUTE, HOUR]

        def initialize(number)
          @number = number
        end

        def print
          number = @number
          puts number
          i = 0
          digits = []
          while number > 0 && i < UNITS.length do
            x = number.modulo(UNITS[i])
            puts "#{number}.modulo(#{UNITS[i]}) => #{x}"
            digits.unshift(x)
            number -= x
            i += 1
          end
          puts digits.join(', ')
          digits
        end
      end
    end
  end
end
