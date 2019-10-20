# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::GT Events
        module Display
          # Cache related events
          module Cache
            HEADER_CACHE = :header_cache
            HEADER_WRITE = :header_write
            MENU_CACHE   = :menu_cache
            MENU_WRITE   = :menu_write
          end

          # Control related events
          module Control
            GT_CONTROL = :data_select
          end

          # State related events
          module State
            GT_MONITOR_ON     = :gt_monitor_on
            GT_MONITOR_OFF    = :gt_monitor_off
            GT_PING           = :gt_ping
            GT_ANNOUNCE       = :gt_announce

            GT_SETTINGS       = :gt_settings
            GT_OBC            = :gt_obc
            GT_CODE           = :gt_code
            GT_AUX            = :gt_aux

            GT_DSP            = :gt_dsp

            GT_STATES = constants.map { |i| const_get(i) }
          end

          include Cache
          include Control
          include State
        end
      end
    end
  end
end
