# frozen_string_literal: true

puts "\tLoading wilhelm/api/vehicle"

module Wilhelm
  module API
    # Vehicle object for vehicle API
    class Vehicle
      include Singleton
      include Helpers::Observation

      PROG = 'Vehicle'

      attr_accessor :bus

      def logger
        LOGGER
      end

      def to_s
        PROG
      end

      def targets
        %i[diag]
      end

      def rear_window_unlock
        bus.dia.rear_window_unlock
      end
    end
  end
end
