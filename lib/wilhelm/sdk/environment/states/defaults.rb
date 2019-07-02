# frozen_string_literal: false

module Wilhelm
  module SDK
    class Environment
      # Thingo
      module Defaults
        # User Control

        def load_ui(___)
          false
        end

        def online!(___)
          false
        end

        def offline!(___)
          false
        end

        def establishing!(___)
          false
        end

        def open(___)
          false
        end

        def close(___)
          false
        end

        def manager!(___)
          false
        end

        def audio!(___)
          false
        end

        def notifications!(___)
          false
        end

        def ui!(___)
          false
        end

        def load_debug(___, ___ = nil)
          false
        end

        def load_services(___)
          false
        end

        def load_bluetooth(___, *)
          false
        end

        def load_audio(___)
          false
        end

        def load_now_playing(___)
          false
        end

        def alive?(___)
          false
        end
      end
    end
  end
end
