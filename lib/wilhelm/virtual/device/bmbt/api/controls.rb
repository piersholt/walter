# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module API
          # BMBT::API::Controls
          module Controls
            include Device::API::BaseAPI

            def bmbt_btn_a(from: :bmbt, to:, arguments:)
              try(from, to, BMBT_A, arguments)
            end

            alias button bmbt_btn_a

            # 0x31 SOFT-INPUT
            # @param Integer layout
            # @param Integer function
            # @param Integer button
            def soft_input(from: :bmbt, to:, **arguments)
              try(from, to, INPUT, arguments)
            end
          end
        end
      end
    end
  end
end
