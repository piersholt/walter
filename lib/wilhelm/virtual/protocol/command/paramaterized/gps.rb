# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        # Command::Parameterized::GPS
        module GPS
          DATE_MASK             = '%2.2i'
          TIME_MASK             = '%2.2i'
          MINUTE_MASK           = '%2.2i'
          SECOND_MASK           = '%2.2i'
          COMBINATION_DELIMITER = 'T'
          DATE_DELIMITER        = '-'
          TIME_DELIMITER        = ':'
          MINUS                 = "\u2212"
          DEGREES               = "\u00b0"
          MINUTES               = "\u2032"
          SECONDS               = "\u2033"
          DECIMAL               = '.'
        end
      end
    end
  end
end

require_relative 'gps/coordinates'
require_relative 'gps/time'
