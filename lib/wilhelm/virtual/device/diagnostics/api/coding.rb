# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Coding
          module Coding
            def coding_read(from: :dia, to:, arguments:)
              try(from, to, 0x08, arguments)
            end

            def coding_write(from: :dia, to:, arguments:)
              try(from, to, 0x09, arguments)
            end
          end
        end
      end
    end
  end
end
