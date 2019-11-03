# frozen_string_literal: true

module Wilhelm
  module API
    class Telephone
      # API::Telephone::Info
      module Info
        MOD_PROG = 'Telephone::Info'

        def info_open(info)
          bus.tel.macro_info(info)
        end
      end
    end
  end
end
