# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Navigation
        module API
          # Navigation::API::Assist
          module Assist
            include Helpers::Parse
            include Constants

            # 0xA9 ASSIST-A9

            # REQUEST 0x03
            # A9 03 30 30 1B   "current network request, count 0"

            # REQUEST 0x0A
            # A9 0A 30 30 12   "current phone status, count:0"

            # REPLY 0x13
            # A9 13 00 00 02 00

            # REPLY 0x32..0x35
            # A9 32 00 00 20 20 20 20 20 20 20             "       "     VIN
            # A9 33 00 00 2D 2D 2D 2D 2D 2D 2D 2D 2D 2D 2D "-----------" REG
            # A9 34 00 00 33 65 72 20 20 20 10             "3er"         VEHICLE TYPE
            # A9 35 00 00 55 4E 4B 4E 4F 57 4E 20 20 20 53 "UNKNOWN   S" COLOUR?
            def assist(from: :tel, to: :nav, arguments:)
              try(from, to, ASSIST, bytes(*arguments))
            end
          end
        end
      end
    end
  end
end
