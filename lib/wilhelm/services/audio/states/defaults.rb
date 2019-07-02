# frozen_string_literal: false

require_relative 'defaults/actions'
require_relative 'defaults/notifications'

module Wilhelm
  module Services
    class Audio
      # Audio::Defaults
      module Defaults
        include Actions
        include Notifications

        # API
        def everyone(*)
          false
        end
      end
    end
  end
end
