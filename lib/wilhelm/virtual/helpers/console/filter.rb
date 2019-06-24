# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Helpers
      module Console
        # Comment
        module Filter
          include Constants::Command::Groups

          def display_handler
            Handler::DisplayHandler
          end

          def s
            display_handler.instance.enable
          end

          def h
            display_handler.instance.disable
          end

          # display_handler FILTERING

          def c
            display_handler.i.clear_filter
          end

          def shutup!(set = NOISEY_NG)
            display_handler.i.hide_command_set(set)
          end

          def touch!
            display_handler.i.h_c(*BUTTON)
          end

          def mid!
            display_handler.i.h_c(*MID)
          end

          alias shh! shutup!

          def ready
            display_handler.i.filter_commands(*READY)
          end

          def buttons
            display_handler.i.filter_commands(*BUTTON)
          end

          def menus
            display_handler.i.filter_commands(*MENUS)
          end

          def diag
            display_handler.i.filter_commands(*DIAGNOSTICS)
          end

          def obc
            display_handler.i.filter_commands(*OBC)
          end

          def ign
            display_handler.i.filter_commands(*IGNITION)
          end

          def tel
            display_handler.i.f_t(*Device::Groups::TELEPHONE + Device::Groups::BROADCAST)
            display_handler.i.f_f(*Device::Groups::TELEPHONE)
            display_handler.i.h_c(
              *SPEED, *TEMPERATURE, *COUNTRY, *VEHICLE, *LAMP,
              *SENSORS, *OBC, *READY, *IGNITION
            )
            display_handler.i.h_c(RAD_LED, SRC_CTL, SRC_SND, MENU_GFX, MENU_RAD)
          end

          def nav
            display_handler.i.f_t(*Device::Groups::NAV)
            display_handler.i.f_f(*Device::Groups::NAV)
            display_handler.i.h_c(
              *SPEED, *TEMPERATURE, *VEHICLE, *LAMP,
              *SENSORS, *OBC, *IGNITION
            )
          end

          def cdc
            display_handler.i.f_t(*Device::Groups::CD)
            display_handler.i.f_f(*Device::Groups::CD)
            display_handler.i.h_c(
              *READY, *SPEED, *TEMPERATURE, *COUNTRY,
              *VEHICLE, *LAMP, *SENSORS, *OBC, *IGNITION
            )
          end

          def cdc!
            display_handler.i.f_t(*Device::Groups::CD)
            display_handler.i.f_f(*Device::Groups::CD)
            display_handler.i.h_c(
              *READY, *SPEED, *TEMPERATURE, *COUNTRY,
              *VEHICLE, *LAMP, *SENSORS, *OBC, *IGNITION
            )

            display_handler.i.h_c(*DISPLAY, *BUTTON)
          end

          def media
            display_handler.i.f_t(*Device::Groups::MEDIA + BROADCAST)
            display_handler.i.f_f(*Device::Groups::MEDIA)
          end
        end
      end
    end
  end
end
