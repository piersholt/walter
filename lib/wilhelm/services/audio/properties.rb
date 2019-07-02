# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Properties
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
end
