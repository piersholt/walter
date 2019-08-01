# frozen_string_literal: true

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module Model
          module Header
            # SDK::Context::UserInterface::Model::Header
            class Status
              include Observable

              ATTRIBUTES = %i[player_name device_name volume_level].freeze
              ATTRIBUTE_INDEX_MAP = { player_name: 5, device_name: 6, volume_level: 0}.freeze
              ATTRIBUTE_DEFAULTS = { player_name: 'No Player', device_name: 'No Device', volume_level: '?' }.freeze

              ATTRIBUTES.each do |attr|
                attr_accessor attr
              end

              def indexed_fields
                seed_fields
              end

              def field(i)
                indexed_fields[i]
              end

              # devices_update() =>
              def device(devices_object)
                return false if devices_object.name.nil? || devices_object.name.empty?
                self.device_name = devices_object.name
                changed
                notify_observers(:device_name, self)
              end

              # devices_update() =>
              def device_removed
                # return false if devices_object.name.nil? || devices_object.name.empty?
                self.device_name = default(:device_name)
                changed
                notify_observers(:device_name, self)
              end

              # player_update() =>
              def player(player_object)
                return false if player_object.name.nil? || player_object.name.empty?
                return false if self.player_name == player_object.name
                self.player_name = player_object.name
                changed
                notify_observers(:player_name, self)
              end

              # target_update() =>
              def target_removed
                self.player_name = default(:player_name)
                changed
                notify_observers(:player_name, self)
              end

              def volume(level)
                self.volume_level = level.to_s
                changed
                notify_observers(:volume_level, self)
              end

              def audio_update(action, audio: nil)
                LOGGER.unknown(self.class.name) { "#audio_update(#{action}, #{audio.class})" }
                return false unless audio
                case action
                when :volume
                  volume(audio.level)
                end
              end

              def devices_update(action, device:)
                LOGGER.unknown(self.class.name) { "#devices_update(#{action}, #{device})" }
                case action
                when :connected
                  device(device)
                when :disconnected
                  device_removed
                when :devices_created
                  device(device)
                when :devices_updated
                  device(device)
                else
                  LOGGER.unknown(self.class.name) { "devices_update: #{action} not implemented." }
                end
              end

              def player_update(action, properties: , player:)
                LOGGER.debug(self.class.name) { "#player_update(#{action}, #{player})" }
                relevant_properties = %i[name track]
                stale = relevant_properties.each { |prop| properties.any?(propr) }
                player(player)
              end

              def target_update(action, target:)
                LOGGER.debug(self.class.name) { "#target_update(#{action}, #{player})" }
                case action
                when :player_removed
                  target_removed
                else
                  LOGGER.debug(self.class.name) { "target_update: #{action} not implemented." }
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
