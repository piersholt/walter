# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module Action
            # Device::Telephone::Emulated::Action::Directory
            module Directory
              include Virtual::Constants::Events::Telephone

              def directory_open!(page: 0, page_size:)
                notify_of_action(
                  DIRECTORY_OPEN,
                  page: page, page_size: page_size
                )
              end

              def directory_back!(page:, page_size:)
                notify_of_action(
                  DIRECTORY_BACK,
                  page: page, page_size: page_size
                )
              end

              def directory_forward!(page:, page_size:)
                notify_of_action(
                  DIRECTORY_FORWARD,
                  page: page, page_size: page_size
                )
              end

              # @note might need state for input
              def directory_select!(index:, page:, page_size:)
                notify_of_action(
                  DIRECTORY_SELECT,
                  index: index, page: page, page_size: page_size
                )
              end
            end
          end
        end
      end
    end
  end
end
