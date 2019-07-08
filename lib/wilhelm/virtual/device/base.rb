# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      # Device::Base
      class Base
        include Observable

        PROC = 'Device::Base'

        attr_reader :ident

        alias me ident

        def initialize(device_ident)
          @ident = device_ident
        end

        def is?(other)
          ident == other
        end

        alias i_am is?

        def moi
          ident.upcase
        end

        def type
          TYPE_BASE
        end

        # @override Object#inspect
        def inspect
          "#<Base :#{@ident}>"
        end

        # @override Object#to_s
        def to_s
          "<:#{@ident}>"
        end

        def virtual_receive(*)
          false
        end

        def virtual_transmit(*)
          false
        end
      end
    end
  end
end
