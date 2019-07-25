# frozen_string_literal: true

require_relative 'target/constants'
require_relative 'target/actions'
require_relative 'target/attributes'
require_relative 'target/notifications'

module Wilhelm
  module Services
    class Audio
      # Audio::Target
      class Target
        include Logging
        include Constants
        include Attributes
        include Notifications
        include Actions

        attr_accessor :players

        def initialize(attributes = {})
          @attributes = attributes
        end

        def is?(other_id)
          id.eq?(other_id)
        end

        def ==(other_object)
          return false unless other_object.respond_to?(:id)
          id == other_object.id
        end

        def path
          attributes[:path]
        end

        alias id path

        def name
          @name ||= Manager::Device.parse_device_path(id)
        end

        # Player Object(s) References

        # connected == true
        # player != nil
        def addressed_player
          debug('#addressed_player', PROG)
          raise NoAddressedPlayer unless player?
          raise NoAddressedPlayer unless players?
          players&.id(player)
        end

        def player?
          return false if player.nil?
          return false if player.empty?
          true
        end

        def players?
          return false if players.nil?
          return false if players.empty?
          true
        end

        # def player_properties_changed(player, properties)
        #   debug("#player_properties_changed(#{player}, #{properties})", PROG)
        #   players.properties_changed(player, properties)
        # end
      end
    end
  end
end
