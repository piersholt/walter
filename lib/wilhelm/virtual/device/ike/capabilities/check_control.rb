# frozen_string_literal: true

require_relative 'check_control/constants'

module Wilhelm
  module Virtual
    class Device
      module IKE
        module Capabilities
          # Device::IKE::Capabilities::CheckControl
          module CheckControl
            include API
            include Constants

            def warn_range(
              layout  = LAYOUT_RANGE_SET,
              options = OPTS_RANGE_SET,
              chars   = CHARS_RANGE_DEFAULT
            )
              ccm_relay(layout: layout, options: options, chars: chars)
            end

            def warn_range_clear(
              layout  = LAYOUT_RANGE_CLEAR,
              options = OPTS_RANGE_CLEAR,
              chars   = CHARS_EMPTY_STRING
            )
              ccm_relay(layout: layout, options: options, chars: chars)
            end
          end
        end
      end
    end
  end
end
