# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Diagnostics
            # Radio::Capabilities::Diagnostics::Info
            module Info
              include API

              INFO = [
                0x86, 0x90, 0x42, 0x13, 0x01, 0x01, 0x32, 0x11, 0x42, 0x01, 0x20, 0x63, 0x30, 0x33
              ].freeze

              def info!(data = INFO)
                a0(arguments: data)
              end
            end
          end
        end
      end
    end
  end
end
