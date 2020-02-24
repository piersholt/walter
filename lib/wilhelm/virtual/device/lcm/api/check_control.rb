# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module API
          # CheckControl
          module CheckControl
            include Device::API::BaseAPI

            # 0x1a TXT_CCM
            def ccm(from: :ccm, to: :ike, **arguments)
              try(from, to, TXT_CCM, arguments)
            end

            # def ccm!
            # end
          end
        end
      end
    end
  end
end
