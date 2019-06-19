# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Capabilities
      module Radio
        # CD Changer Reqests
        module CDChangerDisplay
          include Wilhelm::Virtual::API::Radio

          # rad  gfx  23  CA 20  "CD 1-01",
          # rad  gfx  23  CA 20  "CD 1-01",
          # rad  gfx  23  CA 20  "CD 1-01",
          # rad  gfx  23  CA 20  "CD 1-01",

          # def alt(mode = :scanning)
          #   case mode
          #   when :scanning
          #
          #   end
          # end

          # [< >] Music search
          def seek(to: :gfx)
            primary(to: to, gfx: 0xc4, ike: 0x20, chars: 'CD 7-SK')
          end

          # rad  gfx  23  C5 20  "CD 1-01  >>",
          # rad  gfx  23  C5 20  "CD 1-01  >>",
          # rad  gfx  23  C5 20  "CD 1-01  >>",
          def fast_forward(to: :gfx)
            primary(to: to, gfx: 0xc5, ike: 0x20, chars: 'CD 9-FF >>')
          end

          # rad  gfx  23  C6 20  "CD 1-01 <<R",
          def rewind(to: :gfx, chars: 'CD 9-RW <<R')
            primary(to: to, gfx: 0xc6, ike: 0x20, chars: chars)
          end

          # [SCAN] Track samole
          # rad     gfx     23      C7 20   "CD 1-13  SC"
          # rad     gfx     23      C7 20   "CD 1-14  SC"
          def sample(to: :gfx)
            primary(to: to, gfx: 0xc7, ike: 0x20, chars: 'CD 7-99')
          end

          # [RANDOM] Random generator
          # rad     gfx     23      C8 20   "CD 1-11 RND"
          # rad     gfx     23      C8 20   "CD 1-12 RND"
          # rad     gfx     23      C8 20   "CD 1-13 RND"
          def shuffle(to: :gfx)
            primary(to: to, gfx: 0xc8, ike: 0x20, chars: 'CD 7-99')
          end

          # [<< >>] Fast forward/reverse
          # rad  gfx  23  C4 20  "CD 1-01 << >>"
          # rad  gfx  23  C4 20  "CD 1-01 << >>"
          def scan(to: :gfx, chars: 'CD 7-99')
            primary(to: to, gfx: 0xca, ike: 0x20, chars: chars)
          end
        end
      end
    end
  end
end
