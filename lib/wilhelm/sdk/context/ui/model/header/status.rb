# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Model
          module Header
            # Comment
            class Status
              include Observable

              ATTRIBUTES = %i[player_name device_name].freeze
              ATTRIBUTE_INDEX_MAP = { player_name: 5, device_name: 6 }.freeze
              ATTRIBUTE_DEFAULTS = { player_name: 'No Player', device_name: 'No Device' }.freeze

              ATTRIBUTES.each do |attr|
                attr_accessor attr
              end

              def indexed_fields
                seed_fields
              end

              def field(i)
                indexed_fields[i]
              end

              def devices(devices_object)
                return false if devices_object.name.nil? || devices_object.name.empty?
                self.device_name = devices_object.name
                changed
                notify_observers(:device_name, self)
              end

              def devices_removed(devices_object)
                return false if devices_object.name.nil? || devices_object.name.empty?
                self.device_name = default(:device_name)
                changed
                notify_observers(:device_name, self)
              end

              def player(player_object)
                return false if player_object.name.nil? || player_object.name.empty?
                self.player_name = player_object.name
                changed
                notify_observers(:player_name, self)
              end

              def devices_update(action, device:)
                LOGGER.debug(self.class.name) { "#devices_update(#{action}, #{device})" }
                case action
                when :connected
                  devices(device)
                when :disconnected
                  devices_removed(device)
                when :created
                  devices(device)
                else
                  LOGGER.debug(self.class.name) { "devices_update: #{action} not implemented." }
                end
              end

              def player_update(action, player:)
                LOGGER.debug(self.class.name) { "#player_update(#{action}, #{player})" }
                case action
                when :addressed_player
                  player(player)
                when :track_change
                  player(player)
                when :status
                  player(player)
                else
                  LOGGER.debug(self.class.name) { "player_update: #{action} not implemented." }
                end
              end

              private

              def seed_fields
                ATTRIBUTES.map do |attribute|
                  seed_field(attribute)
                end&.to_h
              end

              def seed_field(attribute)
                [index(attribute), value?(attribute) ? public_send(attribute) : default(attribute)]
              end

              def value?(attribute)
                public_send(attribute)
              end

              def index(attribute)
                validate_attribute(attribute)
                ATTRIBUTE_INDEX_MAP[attribute]
              end

              def default(attribute)
                validate_default(attribute)
                ATTRIBUTE_DEFAULTS[attribute]
              end

              def validate_attribute(attribute)
                return true if ATTRIBUTE_INDEX_MAP.key?(attribute)
                raise(ArgumentError, invalid_attribute_message(attribute))
              end

              def validate_default(attribute)
                return true if ATTRIBUTE_DEFAULTS.key?(attribute)
                raise(ArgumentError, invalid_default_message(attribute))
              end

              def invalid_attribute_message(attribute)
                "Unrecognised attribute #{attribute}! Valid attributes: #{ATTRIBUTE_INDEX_MAP.keys}"
              end

              def invalid_default_message(attribute)
                "Unrecognised default #{attribute}! Valid attributes: #{ATTRIBUTE_DEFAULTS.keys}"
              end
            end
          end
        end
      end
    end
  end
end
