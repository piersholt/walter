# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module LCM
            # Diagnostics::Capabilities::LCM::Coding
            module Coding
              include Constants

              VALID_CODING_ADDRESS = (0x00..0x12)

              # READ
              # 3F 04 D0 08 00 E3
              # 3F 04 D0 08 01 E2
              # 3F 04 D0 08 02 E1
              # 3F 04 D0 08 03 E0
              # 3F 04 D0 08 04 E7
              # 3F 04 D0 08 05 E6
              # 3F 04 D0 08 06 E5
              # 3F 04 D0 08 07 E4
              # 3F 04 D0 08 08 EB
              # 3F 04 D0 08 09 EA
              # 3F 04 D0 08 0A E9
              # 3F 04 D0 08 0B E8
              # 3F 04 D0 08 0C EF
              # 3F 04 D0 08 0D EE
              # 3F 04 D0 08 0E ED
              # 3F 04 D0 08 0F EC
              # 3F 04 D0 08 10 F3
              # 3F 04 D0 08 11 F2
              # 3F 04 D0 08 12 F1

              def lcm_coding(address)
                return false unless valid_lcm_coding_address?(address)
                coding_read(to: :lcm, arguments: [address])
              end

              # WRITE
              # 1. write (address 0x00)
              # 3F ..	D0 09 00 00 00 00 00 00 40 74 00 00 00 00 00 00 00 00 00 4E 40 90 00 00 01 00 00 00 00 00 00 00 00 00

              # 2. acknowledge
              # D0 ..	3F A0 --

              # 3. read written address (0x00)
              # 3F ..	D0 08 00

              # 4. coding data (to compare with that written)
              # D0 ..	3F A0 00 00 00 00 00 00 40 74 00 00 00 00 00 00 00 00 00 4E 40 90 00 00 01 00 00 00 00 00 00 00 00 00

              # 3F 23 D0 09 [00] [00 00 00 00 00 40 74 00 00 00 00 00 00 00 00 00 4E 40 90 00 00 01 00 00 00 00 00 00 00 00 00] 6E
              # 3F 23 D0 09 [01] [01 82 87 E2 65 63 65 18 07 D6 86 C4 18 26 0B 13 9E 04 04 13 86 02 03 5F 20 02 C6 01 5D 26 03] 24
              # 3F 23 D0 09 [02] [15 88 20 D6 86 C4 18 26 0B 12 86 02 07 12 9E 04 03 15 89 33 F6 02 53 27 3C F6 01 5E 26 37 F6] 9C
              # 3F 23 D0 09 [03] [01 CC 2C 32 F6 01 C4 26 2D F6 01 C5 C1 20 26 26 5F F7 01 60 C6 02 F7 01 61 5F F7 01 62 F7 01] 59
              # 3F 23 D0 09 [04] [63 F7 01 64 F7 01 65 F7 01 66 F7 01 67 CC BC AD 8F AD 00 5F F7 01 CC F6 0D 38 C4 02 27 22 F6] CE
              # 3F 23 D0 09 [05] [0D 36 C4 20 26 1B 13 88 20 17 12 92 20 05 15 8B 04 20 0E 12 93 20 07 F6 0D 23 C4 08 27 03 14] 1D
              # 3F 23 D0 09 [06] [8B 04 F6 0D 26 C4 01 27 15 F6 05 40 27 07 5F F7 05 40 F7 01 E0 D6 9B 26 05 C6 FF F7 05 40 F6] 1D
              # 3F 23 D0 09 [07] [0D 23 2C 2F F6 0D 23 C4 04 27 28 13 85 10 11 D6 82 27 0D F6 01 89 C4 04 26 06 CE 01 89 1D 00] D4
              # 3F 23 D0 09 [08] [02 12 85 10 0F CE 01 89 1D 00 07 CE 01 89 1D 00 70 15 8A 06 C6 01 D7 26 D6 9B C1 07 24 10 F6] D6
              # 3F 23 D0 09 [09] [02 14 C1 03 26 09 F6 01 5E 27 04 5F F7 01 68 F6 0D 28 C4 04 27 77 D6 82 26 0D 5F F7 05 53 F7] 49
              # 3F 23 D0 09 [0A] [05 52 D7 BC D7 BD 20 66 F6 01 BC C4 10 27 15 D6 BC C1 03 23 0F F6 05 52 C1 03 24 08 C6 B4 F7] 3C
              # 3F 23 D0 09 [0B] [05 50 7C 05 52 F6 05 50 27 12 7A 05 50 CE 04 C4 1D 00 10 CE 04 CD 1C 00 01 5F D7 BC F6 01 BC] 6F
              # 3F 23 D0 09 [0C] [C4 20 27 15 D6 BD C1 03 23 0F F6 05 53 C1 03 24 08 C6 B4 F7 05 51 7C 05 53 F6 05 51 27 12 7A] C2
              # 3F 23 D0 09 [0D] [05 51 CE 04 C4 1D 00 20 CE 04 CD 1C 00 01 5F D7 BD 39 00 00 00 00 00 00 00 00 00 00 00 00 00] B9
              # 3F 23 D0 09 [0E] [01 14 73 D3 9A 93 5C 5C 56 EC 07 EA 4E 88 88 88 88 71 5E 51 47 3F 36 2F 2F 2F 2F 2F 2F 2F BA] CB
              # 3F 23 D0 09 [0F] [F0 7D FF 20 1F 5A 32 00 01 00 00 00 00 00 00 24 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00] CA
              # 3F 23 D0 09 [10] [7F 7F 7F 7F 7F 7F A5 94 8B 84 00 00 00 83 86 00 91 00 FF 98 84 6C 84 64 6E 00 00 00 00 00 00] 7E
              # 3F 23 D0 09 [11] [FE 31 32 00 28 07 D0 00 28 42 68 3B 4C F2 01 05 0A 23 96 0A 0A 24 32 12 FF 64 00 00 00 00 00] 75
              # 3F 23 D0 09 [12] [FF FF FF FF FF FF FF FF FF FF FF FF C7 FF FF FF 7F E0 FF 8F 1F FF FF FF FF 01 23 45 00 00 00] 78

              def lcm_coding!(*)
                false
              end

              private

              def valid_lcm_coding_address?(address)
                VALID_CODING_ADDRESS.cover?(address)
              end
            end
          end
        end
      end
    end
  end
end
