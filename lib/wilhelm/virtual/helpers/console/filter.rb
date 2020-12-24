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
            dh.filter_commands(*ids)
          end

          alias fc f_c

          def ready
            dh.filter_commands(*READY)
          end

          def status
            dh.filter_commands(*READY, *IGNITION)
          end

          def input
            dh.filter_commands(INPUT)
          end

          def buttons
            dh.filter_commands(*BUTTON)
          end

          def volume
            dh.filter_commands(*VOLUME)
          end

          def menus
            dh.filter_commands(*MENUS)
          end

          def diag
            dh.filter_commands(*DIAGNOSTICS)
          end

          def obc
            dh.filter_commands(*OBC)
          end

          def ign
            dh.filter_commands(*IGNITION)
          end

          def tel
            dh.filter_commands(*TELEPHONE)
          end

          def odo
            dh.filter_commands(*ODOMETER)
          end

          def si
            dh.filter_commands(*VEHICLE)
          end

          alias vehicle si
          alias veh     si

          def ccm
            dh.filter_commands(*CCM)
          end

          def lamp
            dh.filter_commands(*LAMP)
          end

          def gps
            dh.filter_commands(*GPS)
          end

          def temp
            dh.filter_commands(*TEMPERATURE)
          end

          def country
            dh.filter_commands(*COUNTRY)
          end

          alias region country

          def ui
            dh.filter_commands(*UI)
          end

          def keyless
            dh.filter_commands(*KEYLESS)
          end
        end
      end
    end
  end
end
