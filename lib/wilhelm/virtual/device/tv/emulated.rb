# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module TV
        # TV::Emulated
        class Emulated < Device::Emulated
          include Capabilities

          PROC = 'TV::Emulated'

          SUBSCRIBE = [PING, IGNITION_REP].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)

            super(message)
          end

          # ED 04 FF 02 01 15
          # No using announce bit as emulated device is driven by IGN anyway...
          # @override Device::Capabilities::Ready.announce
          def announce
            super(to: :glo_h, status: 0x00)
          end

          # IDENT

          # MK1
          # ED 0F 3F A0 88 37 55 53 06 01 01 06 21 97 09 16 6D
          # PN: 88 37 55 53
          # HW: 06
          # CI: 01
          # DI: 01
          # BI: 06
          # DATE: 21/97
          # SU: 09
          # SW: 16

          # MK3
          # ED 0F 3F A0 86 91 12 21 05 02 02 11 41 01 09 11 15
          # PN: 86 91 12 21
          # HW: 05
          # CI: 02
          # DI: 02
          # BI: 11
          # DATE: 41/01
          # SU: 09
          # SW: 11

          # CODING
          # MK1
          # 3F 08 ED 06 03 00 00 6F 01 B1
          # ED 04 3F A0 0D 7B
          # 3F 08 ED 06 03 00 00 7F 01 A1
          # ED 04 3F A0 00 76

          # ERRORS
          # dia     tv      REG-14          01
          # tv      dia     DIA-A0-OKAY     03 09 11 0B 04 0D 18

          # STATUS
          # dia     tv      DIA-0B-STATUS   01
          # tv      dia     DIA-A0-OKAY     02

          # dia     tv      DIA-0B-STATUS   02
          # tv      dia     DIA-A0-OKAY     00

          # dia     tv      DIA-0B-STATUS   03
          # tv      dia     DIA-A0-OKAY     0E

          # dia     tv      DIA-0B-STATUS   04
          # tv      dia     DIA-A0-OKAY     00
        end
      end
    end
  end
end
