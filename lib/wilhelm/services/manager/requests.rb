# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Comment
      module Requests
        include Logging

        def devices?
          devices!(devices_callback(self))
        end
      end
    end
  end
end
