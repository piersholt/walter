# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class ServicesContext
        # Context::Services::Context::Registration
        module Registration
          include Logging

          def services
            @services ||= []
          end

          def register_service(service_name, service_object)
            add_observer(service_object, :state_change)
            service_object.services_context = self
            instance_variable_set(inst_var(service_name), service_object)
            services << service_object
            self.class.class_eval do
              attr_reader service_name
            end
          end

          private

          def semaphore
            @semaphore ||= Mutex.new
          end

          def inst_var(name)
            name_string = name.id2name
            ('@' + name_string).to_sym
          end
        end
      end
    end
  end
end
