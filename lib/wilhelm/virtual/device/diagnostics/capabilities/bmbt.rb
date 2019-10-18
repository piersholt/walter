# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          module BMBT
            include API

            # @deprecated API deleted
            # def bmbt_service_mode(string)
            #   mapped_integers = string.split(' ').map { |i| i.to_i(16) }
            #   arguments = array(mapped_integers)
            #   api_service_mode_reply(from: :bmbt, to: :gt, arguments: arguments)
            # end

            # BMBT --> LKM : Light dimmer status request
            # // To NAV locat F0 03 D0 5D 7E
            #
            # GT --> BMBT: RGB control: LCD_off TV
            # // off 3B 05 F0 4F 01 01 81
            # GT --> BMBT: RGB control: LCD_on TV
            # // on 3B 05 F0 4F 11 11 81
          end
        end
      end
    end
  end
end
