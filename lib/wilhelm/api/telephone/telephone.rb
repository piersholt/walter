# frozen_string_literal: true

module Wilhelm
  module API
    # Telephone object for vehicle API
    class Telephone
      include Singleton
      include Observable

      include LED

      PROG = 'Telephone'

      attr_accessor :bus

      def logger
        LOGGER
      end

      def to_s
        PROG
      end

      # TODO: module
      def incoming(caller_id = nil)
        caller_id unless caller_id.nil?
        false
      end
    end
  end
end
