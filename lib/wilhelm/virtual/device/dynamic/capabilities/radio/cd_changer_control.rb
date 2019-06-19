# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Capabilities
      module Radio
        # CD Changer Reqests
        module CDChangerControl
          include Wilhelm::Virtual::API::Radio

          # 0x00: Status!
          # 0x01: Stop!
          # 0x03: Play!
          # 0x04: Scan! (RWD/FFD)
          # 0x05: Seek! (Previous/Next)
          # 0x06: Change Disc!
          # 0x07: Scan Mode!
          # 0x08: Random Mode!
          # 0x0A: Change Track!

          def status!
            cd_changer_request(arguments: { control: 0x00, mode: 0x00 })
          end

          def stop!
            cd_changer_request(arguments: { control: 0x01, mode: 0x00 })
          end

          def play!
            cd_changer_request(arguments: { control: 0x03, mode: 0x00 })
          end

          # SCAN (FWD/RWD), SEEK (next, previous)

          def fwd!
            cd_changer_request(arguments: { control: 0x04, mode: 0x00 })
            Kernel.sleep(2)
            play!
          end

          # alt mode
          def rwd!
            cd_changer_request(arguments: { control: 0x04, mode: 0x01 })
            Kernel.sleep(2)
            play!
          end

          def next!
            cd_changer_request(arguments: { control: 0x05, mode: 0x00 })
          end

          def previous!
            cd_changer_request(arguments: { control: 0x05, mode: 0x01 })
          end

          def change_disc!(disc)
            cd_changer_request(arguments: { control: 0x06, mode: disc })
          end

          def track!; end

          # Modes
          def scan; end

          def random; end

        end
      end
    end
  end
end
