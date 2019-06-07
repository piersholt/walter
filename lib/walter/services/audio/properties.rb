# frozen_string_literal: true

class Walter
  class Audio
    # Comment
    module Properties
      def target
        @target ||= Target.new
      end

      def player
        @player ||= Player.new
      end
    end
  end
end
