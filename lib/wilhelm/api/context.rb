# frozen_string_literal: false

module Wilhelm
  module API
    # API container
    class Context
      def initialize(virtual_context)
        display_api   = Display.instance
        button_api    = Controls.instance
        audio_api     = Audio.instance
        telephone_api = Telephone.instance

        display_api.bus   = virtual_context
        button_api.bus    = virtual_context
        audio_api.bus     = virtual_context
        telephone_api.bus = virtual_context

        button_api.targets.each do |target|
          device = virtual_context.public_send(target)
          device.add_observer(button_api)
        end

        display_api.targets.each do |target|
          device = virtual_context.public_send(target)
          device.add_observer(display_api)
        end
      end
    end
  end
end
