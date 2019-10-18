# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module CDChanger
            # CD Changer Display
            module Display
              include API

              # rad  gt  23  CA 20  "CD 1-01",
              # rad  gt  23  CA 20  "CD 1-01",
              # rad  gt  23  CA 20  "CD 1-01",
              # rad  gt  23  CA 20  "CD 1-01",

              # def alt(mode = :scanning)
              #   case mode
              #   when :scanning
              #
              #   end
              # end

              # [< >] Music search
              def seek(to: :gt)
                primary(to: to, gt: 0xc4, ike: 0x20, chars: 'CD 7-SK')
              end

              # rad  gt  23  C5 20  "CD 1-01  >>",
              # rad  gt  23  C5 20  "CD 1-01  >>",
              # rad  gt  23  C5 20  "CD 1-01  >>",
              def fast_forward(to: :gt)
                primary(to: to, gt: 0xc5, ike: 0x20, chars: 'CD 9-FF >>')
              end

              # rad  gt  23  C6 20  "CD 1-01 <<R",
              def rewind(to: :gt, chars: 'CD 9-RW <<R')
                primary(to: to, gt: 0xc6, ike: 0x20, chars: chars)
              end

              # [SCAN] Track samole
              # rad     gt     23      C7 20   "CD 1-13  SC"
              # rad     gt     23      C7 20   "CD 1-14  SC"
              def sample(to: :gt)
                primary(to: to, gt: 0xc7, ike: 0x20, chars: 'CD 7-99')
              end

              # [RANDOM] Random generator
              # rad     gt     23      C8 20   "CD 1-11 RND"
              # rad     gt     23      C8 20   "CD 1-12 RND"
              # rad     gt     23      C8 20   "CD 1-13 RND"
              def shuffle(to: :gt)
                primary(to: to, gt: 0xc8, ike: 0x20, chars: 'CD 7-99')
              end

              # [<< >>] Fast forward/reverse
              # rad  gt  23  C4 20  "CD 1-01 << >>"
              # rad  gt  23  C4 20  "CD 1-01 << >>"
              def scan(to: :gt, chars: 'CD 7-99')
                primary(to: to, gt: 0xca, ike: 0x20, chars: chars)
              end
            end
          end
        end
      end
    end
  end
end
