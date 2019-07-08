# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      # Device::Dynamic
      class Dynamic < Base
        include Wilhelm::Virtual::Constants::Command::Aliases

        PROC = 'Device::Dynamic'

        attr_reader :state

        def self.builder
          Builder.new
        end

        PUBLISH = [].freeze
        SUBSCRIBE = [].freeze

        def initialize(args)
          super(args)
          @state = Enabled.new
        end

        def logger
          LOGGER
        end

        def change_state(new_state)
          return false if new_state.class == @state.class
          LOGGER.debug(PROC) { "State => #{new_state.class}" }
          @state = new_state
        end

        def enabled?
          @state.enabled?(self)
        end

        def disabled?
          @state.disabled?(self)
        end

        def enable!
          @state.enable!(self)
        end

        alias enable enable!

        def disable!
          @state.disable!(self)
        end

        alias disable disable!

        # @override Device::Base.virtual_receive
        def virtual_receive(message)
          @state.virtual_receive(self, message)
        end

        # @override Device::Base.virtual_transmit
        def virtual_transmit(message)
          @state.virtual_transmit(self, message)
        end

        def publish?(command_id)
          self.class.const_get(:PUBLISH).include?(command_id)
        end

        def subscribe?(command_id)
          self.class.const_get(:SUBSCRIBE).include?(command_id)
        end

        def handle_virtual_receive(*)
          LOGGER.warn(PROC) { 'handle_virtual_receive not overridden!' }
          false
        end

        def handle_virtual_transmit(*)
          LOGGER.warn(PROC) { '#handle_virtual_transmit not overridden!' }
          false
        end
      end
    end
  end
end
