# require '/api/base_api'

# frozen_string_literal: true

module Wilhelm
  module Virtual
    module API
      module RadioLED
        include Wilhelm::Virtual::Constants::Command::Aliases
        include BaseAPI

        # 0x4A / Radio LED
        # def switch(from: 0x68, to: 0xf0, led:)
        #   give_it_a_go(from, to, 0x4a, led: led)
        # end

        # 0x4B / Audio Device Control?
        # def control(from: 0xf0, to: 0x68, c: 0x06, m: 0x30)
        #   give_it_a_go(from, to, 0x4b, control: c, mode: m)
        # end
        #
        # def radio
        #   control(c: 0x05, m: 0x05)
        # end

        def l3d(from: :rad, to: :bmbt, **arguments)
          try(from, to, RAD_LED, arguments)
        end
      end
    end
  end
end
