# frozen_string_literal: true

# # require '/api/base_api'

module API
  # API for command related to keys
  module OnBoardMonitor
    include CommandAliases
    include BaseAPI

    def button(from: :bmbt, to:, arguments:)
      try(from, to, BMBT_A, arguments)
    end
  end
end
