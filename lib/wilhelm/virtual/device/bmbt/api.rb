# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        # API for command related to keys
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          def bmbt_btn_a(from: :bmbt, to:, arguments:)
            try(from, to, BMBT_A, arguments)
          end

          alias button bmbt_btn_a
        end
      end
    end
  end
end
