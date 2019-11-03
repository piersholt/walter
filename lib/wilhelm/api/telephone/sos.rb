# frozen_string_literal: true

module Wilhelm
  module API
    class Telephone
      # API::Telephone::SOS
      module SOS
        MOD_PROG = 'Telephone::SOS'

        def sos_open(telematics)
          bus.tel.open_sos(telematics)
        end
      end
    end
  end
end
