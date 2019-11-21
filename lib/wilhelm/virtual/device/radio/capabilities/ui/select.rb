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

              def select_a
                rad_alt(mode: SELECT_OPTION_1 | SELECT_BM53 | SELECT_RADIO | SELECT_HIGHLIGHT)
              end

              def select_b
                rad_alt(mode: SELECT_OPTION_2 | SELECT_BM53 | SELECT_RADIO | SELECT_HIGHLIGHT)
              end

              def select_c
                rad_alt(mode: SELECT_OPTION_3 | SELECT_BM53 | SELECT_RADIO | SELECT_HIGHLIGHT)
              end

              def select_d
                rad_alt(mode: SELECT_OPTION_4 | SELECT_BM53 | SELECT_RADIO | SELECT_HIGHLIGHT)
              end

              def select_c23_a
                rad_alt(mode: SELECT_OPTION_1 | SELECT_C23)
              end

              def select_c23_b
                rad_alt(mode: SELECT_OPTION_2 | SELECT_C23)
              end

              def select_c23_c
                rad_alt(mode: SELECT_OPTION_3 | SELECT_C23)
              end

              def select_c23_d
                rad_alt(mode: SELECT_OPTION_4 | SELECT_C23)
              end
            end
          end
        end
      end
    end
  end
end
