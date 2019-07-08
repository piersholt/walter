# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      # Comment
      class Emulated < Dynamic
        include Capabilities::Ready

        PROC = 'Device::Emulated'.freeze

        def initialize(args)
          super(args)
        end

        def type
          TYPE_EMULATED
        end

        # @override Object#inspect
        def inspect
          "#<Emulated :#{@ident}>"
        end

        # @override Device::Dynamic
        def handle_virtual_receive(message)
          command_id = message.command.d
          case command_id
          when PING
            pong
          end
        end
      end
    end
  end
end
