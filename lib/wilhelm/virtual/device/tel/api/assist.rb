# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module API
          # Telephone::API::Assist
          module Assist
            include Helpers::Parse
            include Device::API::BaseAPI
            include Constants

            # 0xA6 TEL-ANZV-A6
            def icon(from: :tel, to: :anzv, arguments:)
              try(from, to, ICON, bytes(*arguments))
            end

            # 0xA9 ASSIST-A9
            def assist(from: :tel, to: :nav, arguments:)
              try(from, to, ASSIST, bytes(*arguments))
            end
          end
        end
      end
    end
  end
end
