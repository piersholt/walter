# frozen_string_literal: false

module Wilhelm
  module Services
    class Telephone
      module Mock
        # Contact Generators
        module Messages
          Message = Struct.new(:ident, :body)
          MESSAGES = [
            Message.new('A. Message', 'this is a message body!'),
            Message.new('B. Message', 'this is a message body!'),
            Message.new('C. Message', 'this is a message body!'),
            Message.new('D. Message', 'this is a message body!'),
            Message.new('E. Message', 'this is a message body!'),
            Message.new('F. Message', 'this is a message body!'),
            Message.new('G. Message', 'this is a message body!'),
            Message.new('H. Message', 'this is a message body!'),
            Message.new('I. Message', 'this is a message body!'),
            Message.new('J. Message', 'this is a message body!'),
            Message.new('K. Message', 'this is a message body!'),
            Message.new('L. Message', 'this is a message body!'),
            Message.new('M. Message', 'this is a message body!'),
            Message.new('N. Message', 'this is a message body!'),
            Message.new('O. Message', 'this is a message body!'),
            Message.new('P. Message', 'this is a message body!'),
            Message.new('Q. Message', 'this is a message body!'),
            Message.new('R. Message', 'this is a message body!'),
            Message.new('S. Message', 'this is a message body!')
          ].freeze

          def messages
            @messages ||= MESSAGES.dup
          end
        end
      end
    end
  end
end
