# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module DSP
        # API for command related to keys
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          def dsp_reply(from: :dsp, to: :gfx, **arguments)
            # LOGGER.unknown('API::DSP') { "#{from}, #{to}, #{arguments}" }
            try(from, to, DSP_REP, arguments)
          end
        end
      end
    end
  end
end
