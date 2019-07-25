# frozen_string_literal: true

# /hci0/dev_70_70_0D_11_CF_29
# org.bluez.MediaControl1
# Player = /org/bluez/hci0/dev_70_70_0D_11_CF_29/player0
# Connected = true

module Wilhelm
  module Services
    class Audio
      class NoAddressedPlayer < StandardError
      end

      class Target
        # Audio::Target::Attributes
        module Attributes
          include Constants
          attr_reader :attributes

          def player
            attributes[PLAYER]
          end

          def connected
            attributes[CONNECTED]
          end

          alias connected? connected

          def disconnected?
            !connected?
          end

          def attributes!(new_target)
            properties_hash = new_target.attributes
            logger.debug(PROG) { "#attributes!(#{properties_hash})" }
            logger.debug(PROG) { self }
            delta = properties_hash.keys
            logger.debug(PROG) { "delta: #{delta}" }

            attributes.merge!(properties_hash)
            logger.debug(PROG) { "@attributes=#{attributes}" }

            # changed
            # notify_observers(:properties_changed, player: self)
          end

          def squish(old, new)
            old.merge(new)
          end
        end
      end
    end
  end
end
