# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Memory
          module Memory
            # 0x06
            def memory_read(from: :dia, to:, arguments:)
              try(from, to, DIA_MEM_READ, arguments)
            end

            # 0x07
            def memory_write(*)
              # DIA_MEM_WRITE
            end
          end
        end
      end
    end
  end
end
