# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      # Audio::Properties
      module Properties
        attr_writer :level

        def targets
          @targets ||= setup_targets
        end

        def players
          @players ||= setup_players
        end

        def target
          targets.selected_target
        end

        def player
          target&.addressed_player
        end

        def level
          @level ||= (32 / 8)
        end

        private

        def setup_targets
          t = Targets.new(self)
          t.add_observer(self, :targets_update)
          t
        end

        def setup_players
          t = Players.new
          t.add_observer(self, :players_update)
          t
        end
      end
    end
  end
end
