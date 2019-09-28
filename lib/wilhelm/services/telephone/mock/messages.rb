# frozen_string_literal: false

module Wilhelm
  module Services
    class Telephone
      module Mock
        # Contact Generators
        module Messages
          MESSAGES = [
            'A. Message',
            'B. Message',
            'C. Message',
            'D. Message',
            'E. Message',
            'F. Message',
            'G. Message',
            'H. Message',
            'I. Message',
            'J. Message',
            'K. Message',
            'L. Message',
            'M. Message',
            'N. Message',
            'O. Message',
            'P. Message',
            'Q. Message',
            'R. Message',
            'S. Message'
          ].freeze

          def messages
            @messages ||= MESSAGES.dup
          end
        end
      end
    end
  end
end
