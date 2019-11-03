# frozen_string_literal: true

puts "\tLoading wilhelm/api/telephone"

require_relative 'telephone/led'
require_relative 'telephone/directory'
require_relative 'telephone/top_8'
require_relative 'telephone/info'
require_relative 'telephone/last_numbers'
require_relative 'telephone/sms'
require_relative 'telephone/sos'
require_relative 'telephone/status'

require_relative 'telephone/listener'

module Wilhelm
  module API
    # Telephone object for vehicle API
    class Telephone
      include Singleton
      include Helpers::Observation

      include Listener
      include Directory
      include Info
      include LastNumbers
      include Top8
      include LED
      include SMS
      include Status
      include SOS

      PROG = 'Telephone'

      attr_accessor :bus

      def logger
        LOGGER
      end

      def to_s
        PROG
      end

      def targets
        %i[tel]
      end
    end
  end
end
