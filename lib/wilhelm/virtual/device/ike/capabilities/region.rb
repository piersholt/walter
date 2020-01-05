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
            CONSUMP_1_L_100     = 0b0000_0000
            CONSUMP_1_MPG_UK    = 0b0000_0001
            CONSUMP_1_MPG_US    = 0b0000_0010
            CONSUMP_1_KM_L      = 0b0000_0011

            CONSUMP_2_L_100     = 0b0000_0000
            CONSUMP_2_MPG_UK    = 0b0000_0100
            CONSUMP_2_MPG_US    = 0b0000_1000
            CONSUMP_2_KM_L      = 0b0000_1100

            RANGE_MLS           = 0b0001_0000
            TIMER_1_12H         = 0b0010_0000
            TIMER_2_12H         = 0b0100_0000
            # NA                = 0b1000_0000

            # Byte 4
            AUX_HEAT            = 0b0000_0001
            AUX_VENT            = 0b0000_0010
            TEMP_GONG           = 0b0000_0100
            DIST_MLS            = 0b0000_1000

            # NA                = 0b0001_0000
            # NA                = 0b0010_0000
            AUX_OP_NONE_OLD     = 0b0100_0000
            # NA                = 0b1000_0000

            def aux_test
              region!(0x01, 0x85, 0x60, 0x42)
            end
          end
        end
      end
    end
  end
end
