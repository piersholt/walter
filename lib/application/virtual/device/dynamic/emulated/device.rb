# require 'application/virtual/stateful'
# require 'application/virtual/alive'
# require 'application/virtual/cd'
# require 'application/virtual/telephone'

class Virtual
  class EmulatedDevice < DynamicDevice
    include Capabilities::Ready

    PROC = 'EmulatedDevice'.freeze

    def initialize(args)
      super(args)
    end

    def type
      :simulated
    end

    # @override Object#inspect
    def inspect
      "#<EmulatedDevice :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end

    # @override Virtual::Device#receive_packet

    def handle_message(message)
      command_id = message.command.d
      case command_id
      when PING
        pong
      end
    end
  end
end
