# frozen_string_literal: false

module Wilhelm
  class Virtual
    module Handler
      # Comment
      class InterfaceHandler < Core::BaseHandler
        include LogActually::ErrorOutput

        def initialize(bus)
          @bus = bus
        end

        NAME = 'InterfaceHandler'.freeze

        def name
          NAME
        end

        def bus_online
          LOGGER.warn(name) { 'Bus Online! Enabling virtual bus.' }
          @bus.online
          @bus.simulated.send_all(:enable)
        end

        def bus_offline
          LOGGER.warn(name) { 'Bus Offline! Disabling virtual bus.' }
          @bus.offline
          @bus.simulated.send_all(:disable)
          @bus.augmented.send_all(:disable)
        end
      end
    end
  end
end
