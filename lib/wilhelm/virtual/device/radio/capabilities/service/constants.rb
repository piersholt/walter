# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Service
            # Radio::Capabilities::Service::Constants
            module Constants
              SERVICE_SERIAL_NO   = 0b0_0010 << 0  # 0x02
              SERVICE_SW_VER      = 0b0_0011 << 0  # 0x03
              SERVICE_GAL         = 0b0_0100 << 0  # 0x04
              SERVICE_F_Q         = 0b0_0101 << 0  # 0x05
              SERVICE_DSP         = 0b0_0110 << 0  # 0x06
              SERVICE_SEEK_LEVEL  = 0b0_0111 << 0  # 0x07
              SERVICE_TP_VOLUME   = 0b0_1000 << 0  # 0x08
              SERVICE_AF          = 0b0_1001 << 0  # 0x09
              SERVICE_REGION      = 0b0_1010 << 0  # 0x0a
            end
          end
        end
      end
    end
  end
end
