# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Memory
          module Memory
            def memory_read(from: :dia, to:, arguments:)
              try(from, to, 0x06, arguments)
            end
          end
        end
      end
    end
  end
end
