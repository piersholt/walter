# frozen_string_literal: true

# Comment
class Wilhelm::Virtual
  class DynamicDevice < Device
    include Wilhelm::Core::Command::Aliases

    DEFAULT_STATUS = :up

    def self.builder
      DynamicDeviceBuilder.new
    end

    def initialize(args)
      super(args)
      @status = DEFAULT_STATUS
    end

    def enable
      @status = :up
    end

    def disable
      @status = :down
    end

    def enabled?
      case @status
      when nil
        false
      when :up
        true
      when :down
        false
      end
    end

    def disabled?
      case @status
      when nil
        false
      when :up
        false
      when :down
        true
      end
    end

    def alt
      @alt ||= AddressLookupTable.instance
    end

    def address(ident)
      alt.get_address(ident)
    end

    def my_address
      alt.get_address(ident)
    end

    # @override Virtual::Device#receive_packet
    # Allows the introduction of custom behaviour
    # def receive_packet(packet)
    #   message = super(packet)
    #   handle_message(message) if enabled?
    # end

    # def publish_packet(packet)
    #   message = super(packet)
    #   handle_publish(message) if enabled?
    # end

    # @override Virtual::Device#virtual_receive (Receivable)
    def virtual_receive(message)
      handle_virtual_receive(message) if enabled?
    end

    # @override Virtual::Device#receive_packet (Receivable)
    def virtual_transmit(message)
      handle_virtual_transmit(message) if enabled?
    end
  end
end
