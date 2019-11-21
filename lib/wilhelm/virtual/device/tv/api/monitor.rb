# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module TV
        module API
          # Monitor
          module Monitor
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # 0x4F SRC-GT
            def src_gt(from: :tv, to: :bmbt, **arguments)
              try(from, to, SRC_GT, arguments)
            end
          end
        end
      end
    end
  end
end
