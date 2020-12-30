# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GM
        # Device::GM::API
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          # 0x76 VIS-ACK
          def visual_indicators(from: :gm, to: :glo_l, arguments:)
            try(from, to, VIS_ACK, arguments)
          end

          def visual_indicators!(*args)
            visual_indicators(arguments: args)
          end
        end
      end
    end
  end
end
