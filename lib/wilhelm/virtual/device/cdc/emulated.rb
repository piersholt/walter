# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module CDC
        # CDC::Emualted
        class Emulated < Device::Emulated
          include Handlers
          include Capabilities

          attr_reader :message, :from, :to,
          :command, :command_id,
          :control, :control_value,
          :mode, :mode_value

          PROC = 'CDC::Emulated'

          def name
            PROC
          end

          def handle_virtual_receive(message)
            id = message.command.id
            case id
            when CDC_REQ
              LOGGER.debug(ident) { "#handle_message => CDC_REQ (#{CDC_REQ})" }
              handle_cd_changer_request(message.command)
              # when TXT_GFX
              #   handle_cd_changer_request(message.command)
            end

            super(message)
          rescue StandardError => e
            LOGGER.error e
          end
        end
      end
    end
  end
end
