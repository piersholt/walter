# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module DSP
        # DSP::Emulated
        class Emulated < Device::Emulated
          PROC = 'DSP::Emulated'

          def handle_virtual_receive(message)
            super(message)
          end
        end
      end
    end
  end
end
