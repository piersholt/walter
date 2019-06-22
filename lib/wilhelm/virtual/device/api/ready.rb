# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module API
        # API for command related to keys
        module Readiness
          include BaseAPI

          def p1ng(from: me, to:)
            try(from, to, 0x01)
          end

          def p0ng(from: me, to: :glo_h, status:)
            try(from, to, 0x02, status: status)
          end
        end
      end
    end
  end
end
