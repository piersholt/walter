# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module Capabilities
          module Diagnostics
            # LCM::Capabilities::Diagnostics::Status
            module Status
              include API

              STATUS = [
                0xc1, 0x40, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00,
                0x00, 0xa5, 0x00, 0x00,
                0x00, 0x00, 0x00, 0xe5,
                0x34, 0x00, 0x0a, 0x00,
                0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00,
                0x00, 0xff, 0xff, 0x00
              ].freeze

              # 0x00 STATUS OF CLAMPS AND VOLTAGES
              CLAMP_30A   = 0b0000_0001
              CLAMP_R     = 0b0100_0000
              CLAMP_30B   = 0b1000_0000

              # 0x09
              BATTERY_VOLTAGE_VOLTS = [0xff].freeze

              # 0x18 OIL LEVEL SENSOR
              OIL_LEVEL_WARN_NORM     = 0b0000_0001   # "oil minimum reached"
              OIL_LEVEL_SENSOR_DEFECT = 0b0000_0010
              OIL_LEVEL_WARN_CRIT     = 0b0000_0100   # "oil loss detected"
              OIL_LEVEL_SENSOR_INPUT  = 0b0000_1000

              OIL_LEVEL_STATUS = [0x00 | OIL_LEVEL_SENSOR_INPUT].freeze

              # THERMAL OIL LEVEL SENSOR (TOG)
              # 0x19 Heating Time
              TIME_HEATING = [0xff, 0xff].freeze

              # 0x21 Cooling Time
              TIME_COOLING = [0xff, 0xff].freeze

              STATUS = [
                # 0x00
                0xc1, 0x40,
                # 0x02
                0x00, 0x00,
                # 0x04
                0x00, 0x00,
                # 0x06
                0x00, 0x00,
                # 0x08
                0x00,
                # 0x09
                *BATTERY_VOLTAGE_VOLTS,
                0x00, 0x00,
                0x00, 0x00, 0x00, 0xe5,
                0x34, 0x00,
                # 0x18
                *OIL_LEVEL_STATUS,
                # 0x19
                *TIME_HEATING,
                # 0x21
                *TIME_COOLING,
                # 0x23
                0x00,
                # 0x24
                0x00, 0x00,
                # 0x26
                0x00, 0x00,
                # 0x28
                0x00, 0xff,
                # 0x30
                0xff, 0x00
              ].freeze

              def status
                @status ||= STATUS.dup
              end

              def status=(*args)
                @status = args
              end

              def status!(data = status)
                a0(arguments: data)
              end
            end
          end
        end
      end
    end
  end
end
