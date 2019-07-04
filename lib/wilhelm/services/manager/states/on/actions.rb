# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class On
        # Manager::On::Actions
        module Actions
          include Logging

          # via ManagerController
          def connect_device(context, device_address)
            logger.info(MANAGER_ON) { ":connect_device => #{device_address}" }
            Wilhelm::API::Telephone.instance.connect
            context.connect(device_address)
          end

          # via ManagerController
          def disconnect_device(context, device_address)
            logger.info(MANAGER_ON) { ":disconnect_device => #{device_address}" }
            context.disconnect(device_address)
          end

          # via Controls
          def load_manager(context, *)
            logger.info(MANAGER_ON) { '#load_manager()' }
            context.context.ui.launch(:manager, :index)
          end
        end
      end
    end
  end
end
