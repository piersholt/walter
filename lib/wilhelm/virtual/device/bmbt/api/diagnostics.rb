# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module API
          # BMBT::API::Diagnostics
          module Diagnostics
            include Device::API::BaseAPI

            def memory_read(from: :bmbt, to:, arguments:)
              dispatch_raw_command(from, to, DIA_MEM_READ, arguments)
            end
          end
        end
      end
    end
  end
end
