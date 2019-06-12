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
  end
end
