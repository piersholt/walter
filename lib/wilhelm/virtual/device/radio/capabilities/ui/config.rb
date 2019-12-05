# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module UserInterface
            # Radio::Capabilities::UserInterface::Config
            module Config
              include API
              include Constants

              # 0b0000_0001
              def main_menu
                menu_rad(state: MAIN_MENU)
              end

              # 0b0000_0010
              def hide_header
                menu_rad(state: HIDE_HEADER)
              end

              # 0b0000_0100
              def hide_select
                menu_rad(state: HIDE_SELECT)
              end

              # 0b0000_1000
              def hide_tone
                menu_rad(state: HIDE_TONE)
              end

              # 0b0000_1100
              def hide_menu
                menu_rad(state: HIDE_MENU)
              end

              # BM53
              # 0b0000_0010
              # 0b0000_1100
              def hide_overlay_ng
                hide_header
                hide_menu
              end

              # C23
              # 0b0000_1110
              def hide_overlay
                menu_rad(state: HIDE_OVERLAY)
              end

              alias main              main_menu
              alias acknowledge_menu  main_menu
              alias hide_panel        hide_header
              alias hide_tone_select  hide_menu
              alias hide_all          hide_overlay
            end
          end
        end
      end
    end
  end
end
