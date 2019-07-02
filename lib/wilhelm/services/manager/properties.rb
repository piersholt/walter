# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Properties
      module Properties
        def devices
          @devices ||= Devices.new
        end
      end
    end
  end
end
