# frozen_string_literal: true

module Capabilities
  module Telephone
    # BMBT Interface Control
    module Directory
      include API::Telephone
      include Constants

      def directory_page(contact_group, i)
        mid(m1: DRAW_DIRECTORY, m2: MID_DEFAULT, m3: PAGE[i], chars: contact_group)
        page_wait
      end

      def favourites_page(contact_group, i)
        mid(m1: DRAW_FAVOURITES, m2: MID_DEFAULT, m3: PAGE[i], chars: contact_group)
        page_wait
      end

      def delegate_directory(action)
        logger.debug(PROC) { "Mock: handling directory..." }
        if action == ACTION_DIR_BACK
          logger.debug(PROC) { "Mock: oh, directory pages back!" }
          render_pending_clearance(:directory)
        elsif action == ACTION_DIR_FORWARD
          logger.debug(PROC) { "Mock: oh, directory pages forward!" }
          render_pending_clearance(:directory)
        elsif action == ACTION_DIR_OPEN
          logger.debug(PROC) { "Mock: oh, directory pages forward!" }
          render_pending_clearance(:directory)
        else
          false
        end
      end

      def delegate_favourites
        logger.debug(PROC) { "Mock: handling favourites..." }
        logger.debug(PROC) { "Mock: oh, directory open!!" }
        render_pending_clearance(:favourites)
      end

      def directory
        contact_groups = generate_contacts(CONTACT_DISPLAY_LIMIT,
                                           CONTACT_PAGE_SIZE,
                                           false)

        contact_groups.each_with_index do |contact_group, i|
          directory_page(contact_group, i)
        end
      end

      def favourites
        contact_groups = generate_contacts(CONTACT_DISPLAY_LIMIT,
                                           CONTACT_PAGE_SIZE,
                                           false)

        contact_groups.each_with_index do |contact_group, i|
          favourites_page(contact_group, i)
        end
      end

      private

      def render_pending_clearance(method)
        logger.debug(PROC) { "Mock: Being drawing :#{method}" }
        # logger.debug(PROC) { "Mock: Firstly clear display :#{method}" }
        clear(method)
        logger.debug(PROC) { "Mock: Register :#{method} as pending..." }
        @render_pending = method
        true
      end

      def release_pending_retry
        logger.debug(PROC) { "Mock: seeing is a render is pending...." }
        if @render_retry.nil?
          logger.debug(PROC) { 'Mock: No render retry......' }
        else
          logger.debug(PROC) { "Mock: retrying: :#{@render_retry}" }
          public_send(@render_retry)
        end
      end

      def release_pending_render
        logger.debug(PROC) { "Mock: seeing is a render is pending...." }
        if @render_pending.nil?
          logger.debug(PROC) { 'Mock: No render pending...' }
        else
          logger.debug(PROC) { "Mock: releasing: :#{@render_pending}" }
          public_send(@render_pending)
          @render_retry = @render_pending
          @render_pending = nil
        end
      end

      def clear_retry
        # logger.debug(PROC) { "Mock: no need to try #{@render_retry} again!" }
        @render_retry = nil
      end

      def page_wait
        Kernel.sleep(WAIT_DEFAULT)
      end

      def clear(display)
        logger.debug(PROC) { "Mock: clearing :#{display}!" }

        m1 =
          case display
          when :directory
            DRAW_DIRECTORY
          when :favourites
            DRAW_FAVOURITES
          end

        mid(m1: m1, m2: MID_DEFAULT, m3: NO_PAGINATION, chars: CLEAR)
      end

      def generate_contacts(number_of_contacts = 1,
                            contacts_per_group = CONTACT_PAGE_SIZE,
                            inversed = false)
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
    end
  end
end
