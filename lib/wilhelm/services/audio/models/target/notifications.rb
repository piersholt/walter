# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Target
        # Audio::Target::Notifications
        module Notifications
          include Observable

          include Constants

          def added
            changed
            notify_observers(:added, target: self)
          end

          def updated
            changed
            notify_observers(:changed, target: self)
          end

          def removed
            attributes[CONNECTED] = false
            changed
            notify_observers(:removed, target: self)
          end
        end
      end
    end
  end
end
