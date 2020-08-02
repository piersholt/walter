# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module UserInterface
            # Radio::Capabilities::UserInterface::Select
            module Select
              include Constants
              include API

              # BM53

              def select_a
                rad_37(mode: SELECT_BM53 | SELECT_A | SOURCE_RADIO | SELECT_HIGHLIGHT)
              end

              def select_b
                rad_37(mode: SELECT_BM53 | SELECT_B | SOURCE_RADIO | SELECT_HIGHLIGHT)
              end

              def select_c
                rad_37(mode: SELECT_BM53 | SELECT_C | SOURCE_RADIO | SELECT_HIGHLIGHT)
              end

              def select_d
                rad_37(mode: SELECT_BM53 | SELECT_D | SOURCE_RADIO | SELECT_HIGHLIGHT)
              end

              # C23 BM

              def select_c23_a
                rad_37(mode: SELECT_C23 | SELECT_A)
              end

              def select_c23_b
                rad_37(mode: SELECT_C23 | SELECT_B)
              end

              def select_c23_c
                rad_37(mode: SELECT_C23 | SELECT_C)
              end

              def select_c23_d
                rad_37(mode: SELECT_C23 | SELECT_D)
              end
            end
          end
        end
      end
    end
  end
end
