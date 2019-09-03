# frozen_string_literal: true

module Wilhelm
  module Helpers
    # Helpers::Time
    module Time
      Periods = Struct.new(:seconds, :minutes, :hours)

      UNIT_BASES = [60, 60, 24].freeze
      TIMER_MASK      = '%.2i'
      TIMER_DELIMITER = ':'

      def duration(total)
        UNIT_BASES.collect do |base|
          total, period = total.divmod(base)
          period
        end
      end

      def formatted(total, digits = 3)
        duration(total).first(digits).reverse.collect do |i|
          format(TIMER_MASK, i)
        end&.join(TIMER_DELIMITER)
      end

      alias ftime formatted

      def time(total)
        Periods.new(*duration(total))
      end
    end
  end
end
