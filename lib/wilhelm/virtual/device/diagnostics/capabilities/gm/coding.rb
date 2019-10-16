# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module GM
            # Diagnostics::Capabilities::GM::Coding
            module Coding
              include Constants

              def gm_coding
                false
                # coding_read(to: :gm, arguments: [address])
              end
            end
          end
        end
      end
    end
  end
end
