# frozen_string_literal: true

class LogActually
  # Comment
  module ASCIIColour
    include Constants

    def severity_colour(severity)
      method_name = SEVERITY_TO_COLOUR_MAP[severity]
      public_send(method_name)
    end

    def clear
      "\e[#{RESET}m"
    end

    def gray
      "\e[#{LIGHT_GRAY}m"
    end

    def green
      "\e[#{GREEN}m"
    end

    def yellow
      "\e[#{YELLOW}m"
    end

    def red
      "\e[#{RED}m"
    end

    def magenta
      "\e[#{MAGENTA}m"
    end
  end
end
