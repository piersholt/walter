# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        module Capabilities
          # Device::IKE::Capabilities::Region
          module Region
            include API
            include Helpers::Data

            CLUSTER_HIGH        = 0b0000_0000

            # :lang
            LANG_DE             = 0b000_0000
            LANG_GB             = 0b000_0001
            LANG_US             = 0b000_0010
            LANG_IT             = 0b000_0011
            LANG_ES             = 0b000_0100
            LANG_JP             = 0b000_0101
            LANG_FR             = 0b000_0110
            LANG_CA             = 0b000_0111
            LANG_AR             = 0b000_1000

            # :b2
            TIME_24H            = 0b0000_0000
            TIME_12H            = 0b0000_0001

            TEMP_C              = 0b0000_0000
            TEMP_F              = 0b0000_0010

            AVG_SPEED_KMH       = 0b0000_0000
            AVG_SPEED_MPH       = 0b0001_0000

            LIMIT_KMH           = 0b0000_0000
            LIMIT_MPH           = 0b0010_0000

            DISTANCE_KM         = 0b0000_0000
            DISTANCE_MLS        = 0b0100_0000

            ARRIVAL_24H         = 0b0000_0000
            ARRIVAL_12H         = 0b1000_0000

            # :b3
            # CONSUMPTION_1 0b0000_0011
            CONSUMP_1_L_100     = 0b0000_0000
            CONSUMP_1_MPG_UK    = 0b0000_0001
            CONSUMP_1_MPG_US    = 0b0000_0010
            CONSUMP_1_KM_L      = 0b0000_0011

            # CONSUMPTION_2 0b0000_1100
            CONSUMP_2_L_100     = 0b0000_0000
            CONSUMP_2_MPG_UK    = 0b0000_0100
            CONSUMP_2_MPG_US    = 0b0000_1000
            CONSUMP_2_KM_L      = 0b0000_1100

            RANGE_KM            = 0b0000_0000
            RANGE_MLS           = 0b0001_0000

            TIMER_1_24H         = 0b0000_0000
            TIMER_1_12H         = 0b0010_0000

            TIMER_2_24H         = 0b0000_0000
            TIMER_2_12H         = 0b0100_0000

            # Byte 4
            AUX_HEATING         = 0b0000_0001
            AUX_VENTILATION     = 0b0000_0010
            MOTOR_DIESEL        = 0b0000_1000

            RCC_TIME            = 0b0001_0000
            BMBT_POST_PU96      = 0b0100_0000

            def aux_equip
              region!(
                CLUSTER_HIGH | LANG_GB,
                TIME_24H | TEMP_C | AVG_SPEED_KMH | LIMIT_KMH | DISTANCE_KM | ARRIVAL_24H,
                CONSUMP_1_L_100 | CONSUMP_2_L_100 | RANGE_KM | TIMER_1_24H | TIMER_2_24H,
                AUX_HEATING | AUX_VENTILATION | BMBT_POST_PU96
              )
            end
          end
        end
      end
    end
  end
end
