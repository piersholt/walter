# frozen_string_literal: false

module Wilhelm
  module Services
    class Audio
      module Defaults
        # Audio::Defaults::Actions
        module Actions
          def volume_up(*)
            false
          end

          def volume_down(*)
            false
          end

          def overlay(*)
            false
          end

          def power(*)
            false
          end

          def next_track(*)
            false
          end

          def prev(*)
            false
          end

          def pause(*)
            false
          end

          def seek_forward(*)
            false
          end

          def seek_backward(*)
            false
          end

          def scan_forward(*)
            false
          end

          def scan_backward(*)
            false
          end

          def load_audio(*)
            false
          end

          def load_now_playing(*)
            false
          end
        end
      end
    end
  end
end
