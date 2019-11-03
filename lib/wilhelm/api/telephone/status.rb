# frozen_string_literal: true

module Wilhelm
  module API
    class Telephone
      # API::Telephone::Status
      module Status
        MOD_PROG = 'Telephone::Status'

        def active!
          bus.tel.active!
        end

        def inactive!
          bus.tel.inactive!
        end

        def on!
          bus.tel.on!
        end

        def off!
          bus.tel.off!
        end

        def incoming!
          bus.tel.incoming!
        end

        def no_friends!
          bus.tel.no_friends!
        end

        def handset!
          bus.tel.handset!
        end

        def handsfree!
          bus.tel.handsfree!
        end
      end
    end
  end
end
