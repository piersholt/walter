# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Helpers
      module Console
        # Virtual::Helpers::Console::Filter::Hide
        module Hide
          include Constants::Command::Groups

          def h_c(*ids)
            dh.hide_commands(*ids)
          end

          alias hc h_c

          def shutup!(set = NOISEY_NG)
            dh.hide_command_set(set)
          end

          alias shh! shutup!

          def touch!
            dh.hide_commands(*BUTTON)
          end
        end
      end
    end
  end
end
