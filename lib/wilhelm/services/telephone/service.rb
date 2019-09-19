# frozen_string_literal: true

module Wilhelm
  module Services
    # Bluetooth Telephone
    class Telephone
      include Helpers::Observation
      include Logging
      include Contacts

      PROG = 'Service::Telephone'

      def initialize(api_object = Wilhelm::API::Telephone.instance)
        @api_object = api_object
        @api_object.register_telephone_listener(self)
      end

      def telephone_update(event, args)
        logger.unknown(PROG) { "#telephone_update(#{event}, #{args})" }
        case event
        when :directory_open
          generate_directory(args)
        when :directory_back
          generate_directory(args)
        when :directory_forward
          generate_directory(args)
        when :directory_select
          directory_select(args)
        end
      end

      private

      def generate_directory(page:, page_size:)
        LOGGER.unknown(PROG) { "#generate_directory(#{page}, #{page_size})" }
        contacts = phone_book.rotate(page * page_size)&.first(page_size)
        @api_object.directory_contact_list(*contacts)
      end

      def directory_select(index:, page:, page_size:)
        LOGGER.unknown(PROG) { "#directory_select(#{index}, #{page}, #{page_size})" }
        contact_name = phone_book.rotate(page * page_size)&.slice(index)
        LOGGER.unknown(PROG) { "contact_name = #{contact_name}" }
        @api_object.directory_name(contact_name)
      end
    end
  end
end
