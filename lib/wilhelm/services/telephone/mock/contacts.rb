# frozen_string_literal: false

module Wilhelm
  module Services
    # Bluetooth Telephone
    class Telephone
      # Contact Generators
      module Contacts
        TOP_8_PAGE_SIZE = 8

        CONTACTS = [
          'A.Anteater',
          'B.Bonkers',
          'C.Cockatoo',
          'D.Donkey',
          'E.Eagle',
          'F.Fatty',
          'G.Gonzo',
          'H.Henderson',
          'I.India',
          'J.Jamie',
          'K.Karen',
          'L.Lorenzo',
          'M.Mario',
          'N.Nelly',
          'O.Ophelia',
          'P.Porridge',
          'Q.Queeny',
          'R.Rogerson',
          'S.Smythson'
        ].freeze

        def favourites
          @favourites ||= CONTACTS.dup.reverse!.first(TOP_8_PAGE_SIZE)
        end

        def phone_book
          @phone_book ||= CONTACTS.dup
        end
      end
    end
  end
end
