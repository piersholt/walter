# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module API
          # API for command related to keys
          module Settings
            include Constants::Command::Aliases
            include Device::API::BaseAPI

            # BOOL

            # Byte A
            # Memo           [On, Off]
            # Timer          [On, Off]
            # Limit          [On, Off]

            # Byte B
            # Aux_Timer_1:   [On, Off]
            # Aux Timer 2:   [On, Off]
            # Aux Direct:    [On, Off]
            # Aux LED Flash: [On, Off]
            # Code:          [On, Off]

            # VAR

            # Time
            # Date

            # Temperature
            # Consumption 1
            # Consumption 2
            # Range
            # Distance
            # Arrival
            # Limit
            # Avg. Speed
            # Timer
            # Timer (Lap)

            # Aux. Timer 1
            # Aux. Timer 2

            # Code: Emergency Disarm

            # 0x24 ANZV-VAR
            def anzv_var(from: :ike, to: :anzv, **arguments)
              # format_chars!(arguments)
              try(from, to, ANZV_VAR, arguments)
            end

            # 0x2a ANZV-BOOL
            def anzv_bool(from: :ike, to: :anzv, **arguments)
              try(from, to, ANZV_BOOL, arguments)
            end
          end
        end
      end
    end
  end
end
