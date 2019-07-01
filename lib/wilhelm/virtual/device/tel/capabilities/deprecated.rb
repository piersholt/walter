# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # BMBT Interface Control
          module Deprecated
            include API
            include Constants

            DIRECTORY_MAX = 8
            FAVOURITES_MAX = 10
            CONTACT_PAGE_SIZE = 2

            # DIRECTORY -------------------------------------------------------

            def directory
              contact_groups = generate_contacts(DIRECTORY_MAX, CONTACT_PAGE_SIZE, false)
              contact_groups.each_with_index do |delimitered_contacts_string, i|
                directory_page(delimitered_contacts_string, i)
              end
            end

            def directory_page(delimitered_contacts_string, i)
              mid(m1: LAYOUT_DIRECTORY, m2: M2_DEFAULT, m3: PAGE[i], chars: delimitered_contacts_string)
            end

            # TOP-8 -----------------------------------------------------------

            def favourites
              contact_groups = generate_contacts(FAVOURITES_MAX, CONTACT_PAGE_SIZE, false)
              contact_groups.each_with_index do |delimitered_contacts_string, i|
                favourites_page(delimitered_contacts_string, i)
              end
            end

            def favourites_page(delimitered_contacts_string, i)
              mid(m1: LAYOUT_TOP_8, m2: M2_DEFAULT, m3: PAGE[i], chars: delimitered_contacts_string)
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

            def clear(display)
              logger.debug(PROC) { "Mock: clearing :#{display}!" }

              m1 =
              case display
              when :directory
                LAYOUT_DIRECTORY
              when :favourites
                LAYOUT_TOP_8
              end

              mid(m1: m1, m2: M2_DEFAULT, m3: M3_FLUSH, chars: CHARS_EMPTY)
            end
          end
        end
      end
    end
  end
end
