# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Helpers
      module Console
        # Virtual::Helpers::Console::Filter::Hide
        module Hide
          include Constants::Command::Groups

          def shutup!(set = NOISEY_NG)
            dh.h_c_s(set)
          end

          alias shh! shutup!

          def touch!
            dh.h_c(*BUTTON)
          end
        end
      end
    end
  end
end
