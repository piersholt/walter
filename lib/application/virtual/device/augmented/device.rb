# frozen_string_literal: true

# Comment
class Virtual
  class AugmentedDevice < DynamicDevice
    include Actions

    PROC = 'AugmentedDevice'.freeze

    def initialize(args)
      super(args)
    end

    def type
      :augmented
    end

    # @override Object#inspect
    def inspect
      "#<AugmentedDevice :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end
  end
end
