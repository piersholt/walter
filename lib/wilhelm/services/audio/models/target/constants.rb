# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Target
        # Audio::Target::Constants
        module Constants
          PROG = 'Audio::Target'

          PLAYER    = 'Player'.to_sym.downcase
          CONNECTED = 'Connected'.to_sym.downcase
        end
      end
    end
  end
end
