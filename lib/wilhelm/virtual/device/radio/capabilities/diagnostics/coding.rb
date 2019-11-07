# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Diagnostics
            # Radio::Capabilities::Diagnostics::Coding
            module Coding
              include API

              CODING = [
                0x00, 0x04, 0x19, 0x01, 0x40, 0x01, 0x01, 0x00
              ].freeze

              def coding!(data = CODING)
                a0(arguments: data)
              end
            end
          end
        end
      end
    end
  end
end
