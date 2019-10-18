# frozen_string_literal: true

puts "\tLoading wilhelm/api/controls"

require_relative 'controls/listener'
require_relative 'controls/control/base'
require_relative 'controls/control/stateless'
require_relative 'controls/control/stateful'
require_relative 'controls/control/two_stage'

require_relative 'controls/control'

# TODO
# - EQ Hifi
# - EQ Top HiFi (DSP)

module Wilhelm
  module API
    # Controls object for vehicle API
    class Controls
      STATELESS = :stateless
      STATEFUL = :stateful

      include Singleton
      include Observable
      include Wilhelm::Helpers::Stateful
      include Listener

      attr_accessor :bus

      alias control_state state

      # HELPERS ----------------------------------------------------

      def logger
        LOGGER
      end

      def to_s
        'Controls'
      end

      def targets
        %i[mfl bmbt rad tel]
      end

      def default_state
        { mfl: {}, bmbt: {} }
      end
    end
  end
end
