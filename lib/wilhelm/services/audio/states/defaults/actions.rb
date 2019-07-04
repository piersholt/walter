# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      module Defaults
        # Audio::Defaults::Actions
        module Actions
          def volume_up(*); end

          def volume_down(*); end

          def overlay(*); end

          def power(*); end

          def next_track(*); end

          def prev(*); end

          def pause(*); end

          def seek_forward(*); end

          def seek_backward(*); end

          def scan_forward(*); end

          def scan_backward(*); end

          # UI

          def load_audio(*); end

          def load_now_playing(*); end
        end
      end
    end
  end
end
