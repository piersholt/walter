# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Helpers
      module Console
        # Virtual::Helpers::Console::Filter
        module Filter
          include Constants::Command::Groups

          def c
            dh.clear_filter
          end

          def f_c(*ids)
            dh.f_c(*ids)
          end

          def ready
            dh.f_c(*READY)
          end

          def input
            dh.f_c(INPUT)
          end

          def buttons
            dh.f_c(*BUTTON)
          end

          def volume
            dh.f_c(*VOLUME)
          end

          def menus
            dh.f_c(*MENUS)
          end

          def diag
            dh.f_c(*DIAGNOSTICS)
          end

          def obc
            dh.f_c(*OBC)
          end

          def ign
            dh.f_c(*IGNITION)
          end

          def tel
            dh.f_c(*TELEPHONE)
          end

          def odo
            dh.f_c(*ODOMETER)
          end

          def si
            dh.f_c(*VEHICLE)
          end

          def ccm
            dh.f_c(*CCM)
          end

          def lamp
            dh.f_c(*LAMP)
          end
        end
      end
    end
  end
end
