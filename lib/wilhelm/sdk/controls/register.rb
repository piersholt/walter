# frozen_string_literal: false

module Wilhelm
  module SDK
    module Controls
      # Base Controls Interface Mapping
      module Register
        include Wilhelm::Virtual::Constants::Buttons::BMBT
        include Wilhelm::Virtual::Constants::Buttons::MFL

        STATELESS_CONTROL = Wilhelm::API::Controls::Control::Stateless
        STATEFUL_CONTROL = Wilhelm::API::Controls::Control::Stateful
        TWO_STAGE_CONTROL = Wilhelm::API::Controls::Control::TwoStage

        STATELESS = :stateless
        STATEFUL = :stateful

        def control_register
          self.class.const_get(:CONTROL_REGISTER)
        end

        def control_routes
          self.class.const_get(:CONTROL_ROUTES)
        end

        def logger_name
          @logger_name ||= self.class.const_get(:LOGGER_NAME)
        end

        def register_controls(controls_api)
          logger.debug(logger_name) { '#register_controls' }
          control_register.each do |control, strategy|
            logger.debug(logger_name) { "Register Control: #{control}, #{strategy}" }
            controls_api.register_control_listener(self, control, strategy)
          end
        end

        def control_event?(event)
          result = event == :button
          logger.debug(logger_name) { "#control_event?(#{event}) => #{result}" }
          result
        end

        def route?(control)
          result = control_routes.key?(control)
          logger.debug(logger_name) { "#route?(#{control}) => #{result}" }
          result
        end

        def route(control)
          result = control_routes[control]
          logger.debug(logger_name) { "#route(#{control}) => #{result}" }
          result
        end

        def stateful?(state)
          result = %i[on off].one? { |s| s == state }
          logger.debug(logger_name) { "#stateful?(#{state}) => #{result}" }
          result
        end

        def stateless?(state)
          result = %i[run].one? { |s| s == state }
          logger.debug(logger_name) { "#stateless?(#{state}) => #{result}" }
          result
        end

        def control_applicable?(type, state)
          if stateful?(state) && type == :stateful
            logger.debug(logger_name) { "#control_applicable?(#{type}, #{state}) => true" }
            true
          elsif stateless?(state) && type == :stateless
            logger.debug(logger_name) { "#control_applicable?(#{type}, #{state}) => true" }
            true
          else
            logger.debug(logger_name) { "#control_applicable?(#{type}, #{state}) => false" }
            false
          end
        end

        def control_update(event, control:, state:)
          logger.debug(logger_name) { "#control_update(#{event}, #{control}, #{state})" }
          return false unless control_event?(event) && route?(control)
          # logger.info(logger_name) { "#control_update(#{event})" }

          route(control).each do |function, type|
            next unless control_applicable?(type, state)
            logger.debug(logger_name) { "routing control #{control} to #{function}..." }
            return public_send(function) if stateless?(state)
            public_send(function, state)
          end
        end
      end
    end
  end
end
