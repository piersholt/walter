# frozen_string_literal: true

module Wilhelm
  module API
    # Telephone object for vehicle API
    class Telephone
      include Singleton
      include Helpers::Observation

      include Listener
      include Directory
      include LastNumbers
      include Top8
      include LED
      include SMS

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
