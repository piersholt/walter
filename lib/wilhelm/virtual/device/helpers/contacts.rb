# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Helpers
        # Contact Generators
        module Contacts
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
            'P.Porridge'
          ].freeze

          CONTACT_PAGE_SIZE = 2
          CONTACT_DELIMITER = 6

          def generate_contacts(number_of_contacts = 1, contacts_per_group = CONTACT_PAGE_SIZE, inversed = false)
            group_count = number_of_contacts.fdiv(contacts_per_group).ceil

            Array.new(group_count) do |group_index|
              full_char_array = Array.new(contacts_per_group) do |contact_index|
                i = (group_index * contacts_per_group) + contact_index
                contacts = generate_contact(i, inversed)
                char_array = contacts.bytes
                char_array.insert(-1, CONTACT_DELIMITER)
              end

              full_char_array.flatten
            end
          end

          def generate_contact(position = 1, inverse = false)
            contacts = CONTACTS.dup
            # contacts = CONTACTS.dup.shuffle
            contacts.reverse! if inverse
            contacts[position]
          end

          def delimiter_contact(contact)
            buffer = contact
            buffer = CONTACT_DELIMITER.chr << buffer
            buffer.bytes
          end
        end
      end
    end
  end
end
