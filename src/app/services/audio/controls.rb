# frozen_string_literal: true

module Wolfgang
  class Audio
    # Comment
    module Controls
      include Logger
      include Vehicle::Events

      AUDIO_CONTROLS = {
        BMBT_POWER => Vehicle::Controls::Control::Stateless,
        BMBT_NEXT => Vehicle::Controls::Control::TwoStage,
        BMBT_PREV => Vehicle::Controls::Control::TwoStage,
        MFL_NEXT => Vehicle::Controls::Control::TwoStage,
        MFL_PREV => Vehicle::Controls::Control::TwoStage,
        MFL_TEL => Vehicle::Controls::Control::Stateless
      }.freeze

      FUNCTION_TYPE = {
        power: Vehicle::Controls::STATELESS,
        seek_forward: Vehicle::Controls::STATELESS,
        seek_backward: Vehicle::Controls::STATELESS,
        scan_forward: Vehicle::Controls::STATEFUL,
        scan_backward: Vehicle::Controls::STATEFUL
      }.freeze

      CONTROL_ROUTES = {
        BMBT_POWER => %i[power],
        BMBT_NEXT => %i[seek_forward scan_forward],
        MFL_NEXT => %i[seek_forward scan_forward],
        BMBT_PREV => %i[seek_backward scan_backward],
        MFL_PREV => %i[seek_backward scan_backward],
        MFL_TEL => %i[pause]
      }.freeze


      def register_controls(controls_api)
        logger.debug(AUDIO) { '#register_controls' }
        AUDIO_CONTROLS.each do |control, strategy|
          logger.debug(AUDIO) { "Register Control: #{control}, #{strategy}" }
          controls_api.register_control_listener(self, control, strategy)
        end
      end

      def button?(event)
        event == :button
      end

      def buttons_update(event, button:, state:)
        logger.debug(AUDIO) { "#buttons_update(#{event}, #{button}, #{state})" }
        return false unless button?(event)
        # return false unless state == :run
        logger.info(AUDIO) { "#buttons_update(#{event})" }

        CONTROL_ROUTES[button].each do |function|
          FUNCTION_TYPE[function]
        end

        case button
        when BMBT_POWER
          power
        when BMBT_NEXT
          return scan_forward(state) unless state == :run
          seek_forward
        when MFL_NEXT
          return scan_forward(state) unless state == :run
          seek_forward
        when BMBT_PREV
          return scan_backward(state) unless state == :run
          seek_backward
        when MFL_PREV
          return scan_backward(state) unless state == :run
          seek_backward
        when MFL_TEL
          pause
        end
      end
    end
  end
end
