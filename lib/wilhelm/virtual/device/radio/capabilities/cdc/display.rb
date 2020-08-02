# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module CDChanger
            # Capabilities::CDChanger::Display
            module Display
              include API
              include Constants

              # rad  gt  23  C5 20  "CD 1-01  >>",
              def fast_forward(
                to: :gt,
                chars: DEFAULT_FF
              )
                draw_23(
                  to:     to,
                  gt:     SOURCE_CDC | CDC_FAST_FORWARD,
                  ike:    0x20,
                  chars:  chars
                )
              end

              alias ff fast_forward

              # rad  gt  23  C6 20  "CD 1-01 <<R",
              def rewind(
                to: :gt,
                chars: DEFAULT_RW
              )
                draw_23(
                  to: to,
                  gt: SOURCE_CDC | CDC_REWIND,
                  ike: 0x20,
                  chars: chars
                )
              end

              alias rw rewind

              # [< >] Music search
              def seek(
                to: :gt,
                chars: DEFAULT_SEEK
              )
                draw_23(
                  to: to,
                  gt: SOURCE_CDC | CDC_SEEK,
                  ike: 0x20,
                  chars: chars
                )
              end

              # [<< >>] Fast forward/reverse
              # rad  gt  23  C4 20  "CD 1-01 << >>"
              def scan(
                to: :gt,
                chars: DEFAULT_SCAN
              )
                draw_23(
                  to: to,
                  gt: SOURCE_CDC | CDC_SCAN,
                  ike: 0x20,
                  chars: chars
                )
              end

              # [SCAN] Track samole
              # rad     gt     23      C7 20   "CD 1-13  SC"
              def sample(
                to: :gt,
                chars: DEFAULT_SAMPLE
              )
                draw_23(
                  to: to,
                  gt: SOURCE_CDC | CDC_SAMPLE,
                  ike: 0x20,
                  chars: chars
                )
              end

              # [RANDOM] Random generator
              # rad     gt     23      C8 20   "CD 1-11 RND"
              def shuffle(
                to: :gt,
                chars: DEFAULT_SHUFFLE
              )
                draw_23(
                  to: to,
                  gt: SOURCE_CDC | CDC_SHUFFLE,
                  ike: 0x20,
                  chars: chars
                )
              end

              # "NO MAGAZINE"
              def no_magazine(
                to: :gt,
                chars: DEFAULT_NO_MAGAZINE
              )
                draw_23(
                  to: to,
                  gt: SOURCE_CDC | NO_MAGAZINE,
                  ike: 0x20,
                  chars: chars
                )
              end

              # "NO DISC"
              def no_disc(
                to: :gt,
                chars: DEFAULT_NO_DISC
              )
                draw_23(
                  to: to,
                  gt: SOURCE_CDC | CDC_NO_DISC,
                  ike: 0x20,
                  chars: chars
                )
              end

              # "CD  -   "
              def disc_load(
                to: :gt,
                chars: DEFAULT_DISC_LOAD
              )
                draw_23(
                  to: to,
                  gt: SOURCE_CDC | CDC_DISC_LOAD,
                  ike: 0x20,
                  chars: chars
                )
              end

              # ------------------------------------------------------------

              def cd_rds(bitmask = 0b0000_0000)
                draw_21(
                  to: :gt,
                  layout: 0xc0,
                  m2: bitmask,
                  m3: 0x06,
                  chars: "FM\x05AM\x05PTY\x05RDS\x05SC\x05MODE"
                )
              end
            end
          end
        end
      end
    end
  end
end
