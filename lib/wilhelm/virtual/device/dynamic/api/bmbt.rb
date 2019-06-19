# frozen_string_literal: true

# # require '/api/base_api'

module Wilhelm
  module Virtual
    module API
      # API for command related to keys
      module OnBoardMonitor
        include Wilhelm::Virtual::Constants::Command::Aliases
        include BaseAPI

        def button(from: :bmbt, to:, arguments:)
          try(from, to, BMBT_A, arguments)
        end
      end
    end
  end
end
