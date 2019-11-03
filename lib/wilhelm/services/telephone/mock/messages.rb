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
            Message.new('A. Message', BODY.dup),
            Message.new('B. Message', BODY.dup),
            Message.new('C. Message', BODY.dup),
            Message.new('D. Message', BODY.dup),
            Message.new('E. Message', BODY.dup),
            Message.new('F. Message', BODY.dup),
            Message.new('G. Message', BODY.dup),
            Message.new('H. Message', BODY.dup),
            Message.new('I. Message', BODY.dup),
            Message.new('J. Message', BODY.dup),
            Message.new('K. Message', BODY.dup),
            Message.new('L. Message', BODY.dup),
            Message.new('M. Message', BODY.dup),
            Message.new('N. Message', BODY.dup),
            Message.new('O. Message', BODY.dup),
            Message.new('P. Message', BODY.dup),
            Message.new('Q. Message', BODY.dup),
            Message.new('R. Message', BODY.dup),
            Message.new('S. Message', BODY.dup)
          ].freeze

          def messages
            @messages ||= MESSAGES.dup
          end
        end
      end
    end
  end
end
