# frozen_string_literal: false

module Wilhelm
  module API
    # API container
    class Context
      attr_reader :display_api, :controls_api, :audio_api, :telephone_api

      alias d display_api
      alias c controls_api
      alias a audio_api
      alias t telephone_api

      def initialize(virtual_context)
        @display_api   = Display.instance
        @controls_api  = Controls.instance
        @audio_api     = Audio.instance
        @telephone_api = Telephone.instance

        display_api.bus   = virtual_context
        controls_api.bus  = virtual_context
        audio_api.bus     = virtual_context
        telephone_api.bus = virtual_context

        controls_api.targets.each do |target|
          device = virtual_context.public_send(target)
          device.add_observer(controls_api)
        end

        display_api.targets.each do |target|
          device = virtual_context.public_send(target)
          device.add_observer(display_api)
        end
      end
    end
  end
end
