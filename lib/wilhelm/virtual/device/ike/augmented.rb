# frozen_string_literal: true

# Comment
module Wilhelm
  module Virtual
    class Device
      module IKE
        # Comment
        class Augmented < Device::Augmented
          include Capabilities

          PUBLISH = [].freeze
          SUBSCRIBE = [].freeze

          PROC = 'AugmentedIKE'

          def moi
            ident.upcase
          end

          def logger
            LOGGER
          end

          def publish?(command_id)
            PUBLISH.include?(command_id)
          end

          def subscribe?(command_id)
            SUBSCRIBE.include?(command_id)
          end

          def handle_virtual_transmit(message)
            command_id = message.command.d
            return false unless publish?(command_id)
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
          end
        end
      end
    end
  end
end
