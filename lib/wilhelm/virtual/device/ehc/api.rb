# frozen_string_literal: true

require_relative 'api/diagnostics'

module Wilhelm
  module Virtual
    class Device
      module EHC
        # EHC::API
        module API
          include Constants::Command::Aliases
          include Device::API::BaseAPI

          include Diagnostics

          # 0x61 EHC-READY
          def ehc_ready(from: :ehc, to: :dia, arguments:)
            try(from, to, 0x61, arguments)
          end
        end
      end
    end
  end
end
