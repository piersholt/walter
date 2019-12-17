# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Tape
            # Radio::Capabilities::Tape::Constants
            module Constants
              include Capabilities::Constants

              # 0x21
              # :layout
              TAPE_SIDE_DOLBY     = 0b0_0011 << 0 # 0x83

              # :m2
              SIDE_INDEX          = 0x00
              SIDE_SIZE           = 2
              DOLBY_INDEX         = 0x02
              DOLBY_SIZE          = 2

              # 0x23
              # :gt
              TAPE_ERROR          = 0b0000 << 0
              TAPE_PLAY_1         = 0b0010 << 0
              TAPE_FF2            = 0b0011 << 0
              TAPE_RW2            = 0b0100 << 0
              TAPE_FF             = 0b0110 << 0
              TAPE_RW             = 0b0111 << 0
              TAPE_CLEAN          = 0b1000 << 0
              TAPE_CHEVRONS       = 0b1001 << 0
              TAPE_PLAY_A         = 0b1010 << 0

              TAPE_SIDE_A         = 0b0 << 4
              TAPE_SIDE_B         = 0b1 << 4

              # :chars
              TAPE_MSG_ERROR    = ' TAPE ERROR'   # 0x80
              TAPE_MSG_PRES_OFF = 'PRES OFF'      # 0x82
              TAPE_MSG_PRES_ON  = 'PRES ON '      # 0x82

              TAPE_MSG_A_PLAY   = ' TAPE A     '  # 0x82
              TAPE_MSG_A_FFF    = ' TAPE A   >>'  # 0x83
              TAPE_MSG_A_FRW    = ' TAPE A <<R '  # 0x84
              TAPE_MSG_A_FF     = ' TAPE A   > '  # 0x86
              TAPE_MSG_A_FF     = ' TAPE A  <R '  # 0x87

              TAPE_MSG_B_PLAY   = ' TAPE B     '  # 0x92
              TAPE_MSG_B_FFF    = ' TAPE B   >>'  # 0x93
              TAPE_MSG_B_FRW    = ' TAPE B <<R '  # 0x94
              TAPE_MSG_B_FF     = ' TAPE B   > '  # 0x96
              TAPE_MSG_B_FF     = ' TAPE B  <R '  # 0x97
            end
          end
        end
      end
    end
  end
end
