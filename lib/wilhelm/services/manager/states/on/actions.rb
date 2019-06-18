# frozen_string_literal: true

module Wilhelm
  class Manager
    class On
      module Actions
        include Constants

        def connect_device(context, device_address)
          logger.info(MANAGER_ON) { ":connect_device => #{device_address}" }
          Wilhelm::API::Telephone.instance.connect
          context.connect(device_address)
        end

        def disconnect_device(context, device_address)
          logger.info(MANAGER_ON) { ":disconnect_device => #{device_address}" }
          context.disconnect(device_address)
        end
      end
    end
  end
end
