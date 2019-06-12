# frozen_string_literal: true

# # require '/api/base_api'

module Wilhelm::Virtual::API
  # API for command related to keys
  module OnBoardMonitor
    include Command::Aliases
    include BaseAPI

    def button(from: :bmbt, to:, arguments:)
      try(from, to, BMBT_A, arguments)
    end
  end
end
