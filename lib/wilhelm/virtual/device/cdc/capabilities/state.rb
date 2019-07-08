# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module CDC
        module Capabilities
          # Device::CDC::Capabilities::State
          module State
            include Constants
            include Wilhelm::Helpers::Stateful
            include Chainable

            DEFAULT_STATE = {
              control: CONTROL[:stopped],
              status: STATUS[:idle],
              magazine: MAGAZINE[:ok],
              loader: LOADER_ONE,
              cd: 1,
              track: 1,
              b4: 0
            }.freeze

            def default_state
              DEFAULT_STATE.dup
            end

            alias current_state state

            def control?
              CONTROL_MAP[current_control]
            end

            def status?
              STATUS_MAP[current_status]
            end

            def current_control
              state[:control]
            end

            def current_status
              state[:status]
            end

            def current_track
              state[:track]
            end

            def current_cd
              state[:cd]
            end

            def next_track
              current_track + 1
            end

            def previous_track
              current_track - 1
            end

            # Intervals for FFD/RWD vs. Next/Previous
            def too_short_to_be_scan?
              elapased_time <= SCAN_THRESHOLD_SECONDS
            end

            def mapped
              current_state.map do |key, value|
                case key
                when :control
                  [:control, CONTROL_MAP[value]]
                when :status
                  [:status, STATUS_MAP[value]]
                when :magazine
                  [:magazine, MAGAZINE_MAP[value]]
                when :loader
                  [:loader, LOADER_MAP[value]]
                else
                  [key, value]
                end
              end.to_h
            end
          end
        end
      end
    end
  end
end
