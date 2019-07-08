# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      # Virtual::Device::Augmented
      class Augmented < Dynamic
        PROC = 'Device::Augmented'

        def initialize(args)
          super(args)
        end

        def type
          TYPE_AUGMENTED
        end

        # @override Object#inspect
        def inspect
          "#<Augmented: #{@ident}>"
        end
      end
    end
  end
end
