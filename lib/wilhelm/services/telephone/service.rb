# frozen_string_literal: true

module Wilhelm
  module Services
    # Bluetooth Telephone
    class Telephone
      include Helpers::Observation
      include Logging
      include Mock
      include Virtual::Constants::Events::Telephone

      PROG = 'Service::Telephone'

      def initialize(api_object = Wilhelm::API::Telephone.instance)
        @api_object = api_object
        @api_object.register_telephone_listener(self)
      end

      def telephone_update(event, args)
        logger.unknown(PROG) { "#telephone_update(#{event}, #{args})" }
        case event
        when DIRECTORY_OPEN
          generate_directory(args)
        when DIRECTORY_BACK
          generate_directory(args)
        when DIRECTORY_FORWARD
          generate_directory(args)
        when DIRECTORY_SELECT
          directory_select(args)
        when LAST_NUMBERS_BACK
          generate_last_numbers(args)
        when LAST_NUMBERS_FORWARD
          generate_last_numbers(args)
        when TOP_8_OPEN
          generate_top_8
        when TOP_8_SELECT
          top_8_select(args)
        when SMS_OPEN
          generate_sms(args)
        when SMS_SELECT
          sms_select(args)
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

      def generate_last_numbers(page:, page_size: 1)
        LOGGER.unknown(PROG) { "#generate_last_numbers(#{page}, #{page_size})" }
        entry = history.rotate(page * page_size)&.first
        @api_object.recent_contact(entry)
      end

      def generate_top_8
        LOGGER.unknown(PROG) { '#generate_top_8' }
        contacts = favourites
        @api_object.top_8_contact_list(*contacts)
      end

      def top_8_select(index:)
        LOGGER.unknown(PROG) { "#top_8_select(#{index})" }
        contact_name = favourites&.slice(index)
        LOGGER.unknown(PROG) { "contact_name = #{contact_name}" }
        @api_object.top_8_name(contact_name)
      end

      def generate_sms(page:, page_size:)
        LOGGER.unknown(PROG) { '#generate_sms' }
        entries = messages.rotate(page * page_size)&.first(page_size)
        @api_object.messages_index(*entries.map(&:ident))
      end

      def sms_select(index:, page:, page_size:)
        LOGGER.unknown(PROG) { "#sms_select(#{index}, #{page}, #{page_size})" }
        entry = messages&.slice(index)
        LOGGER.unknown(PROG) { "entry = #{entry}" }
        @api_object.messages_show(entry)
      end
    end
  end
end
