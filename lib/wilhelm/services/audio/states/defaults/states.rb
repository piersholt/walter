# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      module Defaults
        # Audio::Defaults::States
        module States
          def disable(*); end

          def pending(*); end

          def off(*); end

          def on(*); end
        end
      end
    end
  end
end
