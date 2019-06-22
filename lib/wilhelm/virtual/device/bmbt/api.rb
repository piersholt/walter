# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        # API for command related to keys
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          def button(from: :bmbt, to:, arguments:)
            try(from, to, BMBT_A, arguments)
          end
        end
      end
    end
  end
end
