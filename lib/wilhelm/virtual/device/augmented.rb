# frozen_string_literal: true

# Comment
module Wilhelm
  module Virtual
    class Device
      class Augmented < Dynamic
        # include Actions

        PROC = 'Device::Augmented'.freeze

        def initialize(args)
          super(args)
        end

        def type
          :augmented
        end

        # @override Object#inspect
        def inspect
          "#<Augmented: #{@ident}>"
        end

        # @override Object#to_s
        def to_s
          "<:#{@ident}>"
        end
      end
    end
  end
end
