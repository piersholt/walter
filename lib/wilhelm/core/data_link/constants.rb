# frozen_string_literal: true

puts "\tLoading wilhelm/core/data_link/constants"

module Wilhelm
  module Core
    # Core::DataLink
    module DataLink
      # Core::DataLink::Constants
      module Constants
        # Core::DataLink::Constants::Events
        module Events
          include Core::Constants::Events
        end

        SYNC = 'Sync /'
        SYNC_HEADER = 'Header /'
        SYNC_TAIL = 'Tail /'
        SYNC_VALIDATION = 'Validate /'
        SYNC_ERROR = 'Error /'
        SYNC_SHIFT = 'Unshift! /'
      end
      include Constants
    end
  end
end
