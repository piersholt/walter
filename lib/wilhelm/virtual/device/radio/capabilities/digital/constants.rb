# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDS
            # Radio::Capabilities::RDS::Constants
            module Constants
              include Capabilities::Constants

              ZERO              = 0x00
              NO_INDEX          = 0x00
              NO_CHARS          = ''

              # 0x23
              LENGTH_TITLE      = 11
              LENGTH_5          = 5
              LENGTH_7          = 7
              LENGTH_20         = 20

              # 0x21
              DIGITAL_MENU_A    = SOURCE_DIGITAL | 0b0_0000 << 0 # 0x60
              DIGITAL_MENU_B    = SOURCE_DIGITAL | 0b0_0001 << 0 # 0x61
              DIGITAL_HEADER    = SOURCE_DIGITAL | 0b0_0010 << 0 # 0x62
              DIGITAL_STATIC    = SOURCE_DIGITAL | 0b0_0011 << 0 # 0x63

              INDEX_0  = 0b0000_0000
              INDEX_1  = 0b0000_0001
              INDEX_2  = 0b0000_0010
              INDEX_3  = 0b0000_0011
              INDEX_4  = 0b0000_0100
              INDEX_5  = 0b0000_0101
              INDEX_6  = 0b0000_0110
              INDEX_7  = 0b0000_0111
              INDEX_8  = 0b0000_1000
              INDEX_9  = 0b0000_1001
              INDEX_10 = 0b0000_1010

              FLUSH    = 0b0010_0000
              BLOCK    = 0b0100_0000
              SELECTED = 0b1000_0000

              # MENU A, B (0x60, 0x61)
              MENU_INDICES = [
                INDEX_0,
                INDEX_1,
                INDEX_2,
                INDEX_3,
                INDEX_4,
                INDEX_5,
                INDEX_6,
                INDEX_7,
                INDEX_8,
                INDEX_9,
                INDEX_10
              ].freeze

              # HEADER (0x62)
              HEADER_INDICES = [
                INDEX_1,
                INDEX_2,
                INDEX_3,
                INDEX_4,
                INDEX_5,
                INDEX_6,
                INDEX_7
              ].freeze

              # MENU (0x63)
              LINE_INDICES = [
                INDEX_1,
                INDEX_2,
                INDEX_3,
                INDEX_4,
                INDEX_5
              ].freeze

              LAYOUT_INDICES = {
                DIGITAL_MENU_A => MENU_INDICES,
                DIGITAL_MENU_B => MENU_INDICES,
                DIGITAL_HEADER => HEADER_INDICES,
                DIGITAL_STATIC => LINE_INDICES
              }.freeze
            end
          end
        end
      end
    end
  end
end
