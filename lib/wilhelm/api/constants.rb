# frozen_string_literal: true

puts "\tLoading wilhelm/api/constants"

module Wilhelm
  class API
    # TODO: Rename to Constants
    module Events
      include Virtual::Constants::States
      include Virtual::Constants::Commands
      include Virtual::Constants::Buttons
    end

    module Constants
      # Wilhelm::API alias
      module States
        include Virtual::Constants::States
      end

      # Wilhelm::API alias
      module Commands
        include Virtual::Constants::Commands
      end

      # Wilhelm::API alias
      module Buttons
        include Virtual::Constants::Buttons
      end
    end
  end
end
