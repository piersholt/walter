# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module DSP
        # DSP::Emulated
        class Emulated < Device::Emulated
          include DSP::API
          PROC = 'DSP::Emulated'

          SUBSCRIBE = [PING, DSP_SET].freeze

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when DSP_SET
              logger.debug(PROC) { "Rx: DSP_SET 0x#{d2h(DSP_SET)}" }
              handle_dsp_set(message.command)
            end

            super(message)
          end
        end
      end
    end
  end
end
