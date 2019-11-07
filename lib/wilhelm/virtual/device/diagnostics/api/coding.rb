# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module API
          # Diagnostics::API::Coding
          module Coding
            # 0x08
            def coding_read(from: :dia, to:, arguments:)
              try(from, to, DIA_COD_READ, arguments)
            end

            # 0x09
            def coding_write(from: :dia, to:, arguments:)
              try(from, to, DIA_COD_WRITE, arguments)
            end
          end
        end
      end
    end
  end
end
