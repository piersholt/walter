# frozen_string_literal: false

module Wilhelm
  module Core
    # DebugTools
    # Helpers for common tasks on CLI
    module Debug
      module Display
        include Command::Groups

        def s
          DisplayHandler.instance.enable
        end

        def h
          DisplayHandler.instance.disable
        end

        # DisplayHandler FILTERING

        def c
          DisplayHandler.i.clear_filter
        end

        def shutup!(set = NOISEY_NG)
          set.each do |group, command_ids|
            LOGGER.debug { "Shutting up: #{group}" }
            DisplayHandler.i.h_c(*command_ids)
          end
        end

        def touch!
          DisplayHandler.i.h_c(*BUTTON)
        end

        def mid!
          DisplayHandler.i.h_c(*MID)
        end

        alias shh! shutup!

        def ready
          DisplayHandler.i.filter_commands(*READY)
        end

        def buttons
          DisplayHandler.i.filter_commands(*BUTTON)
        end

        def menus
          DisplayHandler.i.filter_commands(*MENUS)
        end

        def diag
          DisplayHandler.i.filter_commands(*DIAGNOSTICS)
        end

        def obc
          DisplayHandler.i.filter_commands(*OBC)
        end

        def ign
          DisplayHandler.i.filter_commands(*IGNITION)
        end

        def tel
          DisplayHandler.i.f_t(*Device::Groups::TELEPHONE + Device::Groups::BROADCAST)
          DisplayHandler.i.f_f(*Device::Groups::TELEPHONE)
          DisplayHandler.i.h_c(
            *SPEED, *TEMPERATURE, *COUNTRY, *VEHICLE, *LAMP,
            *SENSORS, *OBC, *READY, *IGNITION
          )
          DisplayHandler.i.h_c(RAD_LED, SRC_CTL, SRC_SND, MENU_GFX, MENU_RAD)
        end

        def nav
          DisplayHandler.i.f_t(*Device::Groups::NAV)
          DisplayHandler.i.f_f(*Device::Groups::NAV)
          DisplayHandler.i.h_c(
            *SPEED, *TEMPERATURE, *VEHICLE, *LAMP,
            *SENSORS, *OBC, *IGNITION
          )
        end

        def cdc
          DisplayHandler.i.f_t(*Device::Groups::CD)
          DisplayHandler.i.f_f(*Device::Groups::CD)
          DisplayHandler.i.h_c(
            *READY, *SPEED, *TEMPERATURE, *COUNTRY,
            *VEHICLE, *LAMP, *SENSORS, *OBC, *IGNITION
          )
        end

        def cdc!
          DisplayHandler.i.f_t(*Device::Groups::CD)
          DisplayHandler.i.f_f(*Device::Groups::CD)
          DisplayHandler.i.h_c(
            *READY, *SPEED, *TEMPERATURE, *COUNTRY,
            *VEHICLE, *LAMP, *SENSORS, *OBC, *IGNITION
          )

          DisplayHandler.i.h_c(*DISPLAY, *BUTTON)
        end

        def media
          DisplayHandler.i.f_t(*Device::Groups::MEDIA + BROADCAST)
          DisplayHandler.i.f_f(*Device::Groups::MEDIA)
        end
      end
    end
  end
end
