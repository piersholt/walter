# frozen_string_literal: true

module Wolfgang
  class Audio
    # Comment
    module Controls
      include Logging
      include Vehicle::Events

      CONTROL_REGISTER = {
        BMBT_POWER => Vehicle::Controls::Control::Stateless,
        BMBT_NEXT => Vehicle::Controls::Control::TwoStage,
        BMBT_PREV => Vehicle::Controls::Control::TwoStage,
        MFL_NEXT => Vehicle::Controls::Control::TwoStage,
        MFL_PREV => Vehicle::Controls::Control::TwoStage,
        MFL_TEL => Vehicle::Controls::Control::Stateless
      }.freeze

      CONTROL_ROUTES = {
        BMBT_POWER => { power: :stateless },
        BMBT_NEXT => { seek_forward: :stateless,
                       scan_forward: :stateful },
        MFL_NEXT => { seek_forward: :stateless,
                      scan_forward: :stateful },
        BMBT_PREV => { seek_backward: :stateless,
                       scan_backward: :stateful },
        MFL_PREV => { seek_backward: :stateless,
                      scan_backward: :stateful },
        MFL_TEL => { pause: :stateless }
      }.freeze

      def register_controls(controls_api)
        logger.debug(AUDIO_CONTROLS) { '#register_controls' }
        CONTROL_REGISTER.each do |control, strategy|
          logger.debug(AUDIO_CONTROLS) { "Register Control: #{control}, #{strategy}" }
          controls_api.register_control_listener(self, control, strategy)
        end
      end

      def control_update(event, control:, state:)
        logger.debug(AUDIO_CONTROLS) { "#control_update(#{event}, #{control}, #{state})" }
        return false unless control_event?(event) && route?(control)
        # logger.info(AUDIO_CONTROLS) { "#control_update(#{event})" }

        route(control).each do |function, type|
          next unless control_applicable?(type, state)
          logger.debug(AUDIO_CONTROLS) { "routing control #{control} to #{function}..." }
          return public_send(function) if stateless?(state)
          public_send(function, state)
        end
      end

      def control_event?(event)
        result = event == :button
        logger.debug(AUDIO_CONTROLS) { "#control_event?(#{event}) => #{result}" }
        result
      end

      def route?(control)
        result = CONTROL_ROUTES.key?(control)
        logger.debug(AUDIO_CONTROLS) { "#route?(#{control}) => #{result}" }
        result
      end

      def route(control)
        result = CONTROL_ROUTES[control]
        logger.debug(AUDIO_CONTROLS) { "#route(#{control}) => #{result}" }
        result
      end

      def stateful?(state)
        result = %i[on off].one? { |s| s == state }
        logger.debug(AUDIO_CONTROLS) { "#stateful?(#{state}) => #{result}" }
        result
      end

      def stateless?(state)
        result = %i[run].one? { |s| s == state }
        logger.debug(AUDIO_CONTROLS) { "#stateless?(#{state}) => #{result}" }
        result
      end

      def control_applicable?(type, state)
        if stateful?(state) && type == :stateful
          logger.debug(AUDIO_CONTROLS) { "#control_applicable?(#{type}, #{state}) => true" }
          true
        elsif stateless?(state) && type == :stateless
          logger.debug(AUDIO_CONTROLS) { "#control_applicable?(#{type}, #{state}) => true" }
          true
        else
          logger.debug(AUDIO_CONTROLS) { "#control_applicable?(#{type}, #{state}) => false" }
          false
        end
      end
    end
  end
end
