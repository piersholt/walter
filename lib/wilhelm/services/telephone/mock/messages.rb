# frozen_string_literal: false

module Wilhelm
  module Services
    class Telephone
      module Mock
        # Contact Generators
        module Messages
          Message = Struct.new(:ident, :body)

          BODY =
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' \
            'Curabitur a mollis dui. ' \
            'Morbi vulputate velit nulla, quis mollis lorem interdum dapibus.'
            .freeze

          MESSAGES = [
            Message.new('A. Message', BODY),
            Message.new('B. Message', BODY),
            Message.new('C. Message', BODY),
            Message.new('D. Message', BODY),
            Message.new('E. Message', BODY),
            Message.new('F. Message', BODY),
            Message.new('G. Message', BODY),
            Message.new('H. Message', BODY),
            Message.new('I. Message', BODY),
            Message.new('J. Message', BODY),
            Message.new('K. Message', BODY),
            Message.new('L. Message', BODY),
            Message.new('M. Message', BODY),
            Message.new('N. Message', BODY),
            Message.new('O. Message', BODY),
            Message.new('P. Message', BODY),
            Message.new('Q. Message', BODY),
            Message.new('R. Message', BODY),
            Message.new('S. Message', BODY)
          ].freeze

          def messages
            @messages ||= MESSAGES.dup
          end
        end
      end
    end
  end
end
