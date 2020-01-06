# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Context::Registration
        module Registration
          include Logging
          include Helpers::Name

          SERVICES_UPDATE_METHOD = :context_change

          def services
            @services ||= []
          end

          def register_service(service_name, service_object)
            # NOTE I'm not sure about this as yet...
            service_object.context = self
            add_observer(service_object, SERVICES_UPDATE_METHOD)
            instance_variable_set(inst_var(service_name), service_object)
            services << service_object
            self.class.class_eval do
              attr_reader service_name
            end
          end
        end
      end
    end
  end
end
