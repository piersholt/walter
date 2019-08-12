# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module Capabilities
          # BMBT::Capabilities::Diagnostics
          module Diagnostics
            include API
            include Helpers::Parse

            def service_mode_version(
              sw_level:       0x01,
              hw_level:       0x02,
              diag_index:     0x03,
              bus_index:      0x04,
              encoding_index: 0x05,
              supplier:       0x06
            )
              args = integers_to_byte_array(
                0x86, 0x91, 0x33, 0x87, hw_level, 0x00, diag_index, bus_index,
                0x22, 0x01, supplier, sw_level, encoding_index, 0x00, 0x00, 0x00
              )
              memory_read(to: :gfx, arguments: args)
            end

            def service_mode_key_function(
              key:                    0xff,
              obm_increment_sensor:   0x02,
              radio_increment_sensor: 0x03
            )
              args = integers_to_byte_array(
                key, obm_increment_sensor, radio_increment_sensor
              )
              memory_read(to: :gfx, arguments: args)
            end
          end
        end
      end
    end
  end
end
