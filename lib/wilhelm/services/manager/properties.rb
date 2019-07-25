# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      # Manager::Properties
      module Properties
        def devices
          @devices ||= setup_devices
        end

        private

        def setup_devices
          d = Devices.new
          d.add_observer(self, :devices_update)
          d
        end
      end
    end
  end
end
