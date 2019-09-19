# frozen_string_literal: false

module Wilhelm
  module API
    # API container
    class Context
      attr_reader :display, :controls, :audio, :telephone

      alias d display
      alias c controls
      alias a audio
      alias t telephone

      # @note backwards compatibility
      alias display_api   display
      alias controls_api  controls
      alias audio_api     audio
      alias telephone_api telephone

      def initialize(virtual_context)
        @display   = Display.instance
        @controls  = Controls.instance
        @audio     = Audio.instance
        @telephone = Telephone.instance

        display.bus   = virtual_context
        controls.bus  = virtual_context
        audio.bus     = virtual_context
        telephone.bus = virtual_context

        controls.targets.each do |target|
          device = virtual_context.public_send(target)
          device.add_observer(controls)
        end

        display.targets.each do |target|
          device = virtual_context.public_send(target)
          device.add_observer(display)
        end

        telephone.targets.each do |target|
          device = virtual_context.public_send(target)
          device.add_observer(telephone)
        end
      end
    end
  end
end
