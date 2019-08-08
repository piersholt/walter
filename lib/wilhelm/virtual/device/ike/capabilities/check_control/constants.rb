# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module Capabilities
          module CheckControl
            # Device::IKE::Capabilities::CheckControl::Constants
            module Constants
              LAYOUT_RANGE_SET   = 0b0001_0001  # 0x11
              LAYOUT_RANGE_CLEAR = 0b0001_0000  # 0x10

              LAYOUT_CODE_SET    = 0b0011_0001  # 0x31
              LAYOUT_CODE_CLEAR  = 0b0011_0011  # 0x33

              # CCM_CLEAR          = 0b0011_0000  # 0x30
              # CCM_RECALL         = 0b0011_0101  # 0x35
              # CCM_PERSIST        = 0b0011_0110  # 0x36
              # CCM_ALERT          = 0b0011_0111  # 0x37
              # CCM_UNKNOWN        = 0b0011_1111  # 0x3f

              OPTS_RANGE_SET     = 0xa4
              OPTS_RANGE_CLEAR   = 0x80

              OPTS_CODE_SET      = 0x44
              OPTS_CODE_CLEAR    = 0x40

              CHARS_RANGE_DEFAULT = '   RANGE  34 KM     '
              CHARS_CODE_DEFAULT  = '      CODE ----     '

              CHARS_EMPTY_STRING  = ''
            end
          end
        end
      end
    end
  end
end
