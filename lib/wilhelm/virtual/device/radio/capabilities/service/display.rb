# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Service
            # Radio::Capabilities::Service
            module Display
              include API
              include Constants

              def serial_number(
                to: :gt,
                chars: '12345678'
              )
                draw_23(
                  to:     to,
                  gt:     SERVICE_SERIAL_NO,
                  ike:    0x20,
                  chars:  chars
                )
              end

              def sw_version(
                to: :gt,
                chars: '12345678'
              )
                draw_23(
                  to:     to,
                  gt:     SERVICE_SW_VER,
                  ike:    0x20,
                  chars:  chars
                )
              end

              def gal(
                to: :gt,
                chars: '1'
              )
                draw_23(
                  to:     to,
                  gt:     SERVICE_GAL,
                  ike:    0x20,
                  chars:  chars
                )
              end

              def fq(
                to: :gt,
                chars: 0xff.chr
              )
                draw_23(
                  to:     to,
                  gt:     SERVICE_F_Q,
                  ike:    0x20,
                  chars:  chars
                )
              end
            end
          end
        end
      end
    end
  end
end
