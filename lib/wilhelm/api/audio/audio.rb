# frozen_string_literal: true

# TODO
# - EQ Hifi
# - EQ Top HiFi (DSP)

module Wilhelm
  module API
    # Audio object for vehicle API
    class Audio
      include Singleton
      include Observable

      include LED

      PROG = 'Audio'

      attr_accessor :bus

      def logger
        LOGGER
      end

      def to_s
        PROG
      end

      # def targets
      #   %i[mfl bmbt]
      # end
    end
  end
end
