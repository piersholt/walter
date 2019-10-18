# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        module API
          # Monitor
          module Monitor
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x4F SRC-GT
            def src_gt(from: :gt, to: :bmbt, arguments:)
              try(from, to, SRC_GT, arguments)
            end
          end
        end
      end
    end
  end
end
