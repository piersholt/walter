# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Cache
        # API::Display::Cache::Base
        class Base
          extend Forwardable

          FORWARD_MESSAGES = %i[
            << push first last each empty? size sort_by length
            to_s count [] find_all find each_with_index find_index
            map group_by delete_at
          ].freeze

          FORWARD_MESSAGES.each do |fwrd_message|
            def_delegator :attributes, fwrd_message
          end

          BLANK_ATTRIBUTE = [].freeze
          NAME = 'Cache::Base'

          attr_reader :attributes

          def logger
            LOGGER
          end

          def name
            self.class.const_get(:NAME)
          end

          def generate_attributes(length = 10, offset = 0)
            Array.new(length) { |i| [i+offset, Value.new] }.to_h
          end

          def [](index)
            attributes[index]
          end

          def cache!(delta_hash)
            logger.debug(name) { "#cache!(#{delta_hash})" }
            attributes.merge!(delta_hash) do |existing_key, old_value, new_value|
              merge(existing_key, old_value, new_value)
            end
          rescue StandardError => e
            LOGGER.error(name) { e }
            e.backtrace.each do |line|
              LOGGER.error(name) { line }
            end
          end

          def overwrite!(delta_hash)
            LOGGER.debug(name) { "#overwrite!(#{delta_hash})" }
            attributes.merge!(delta_hash) do |_, _, new_value|
              Value.new(new_value, dirty: false)
            end
          end

          alias attributes! cache!
          alias write! cache!

          # Only applies to menus
          def show!
            # dirty
          end

          def dirty
            result = attributes.find_all { |_, value| value.dirty }
            # logger.debug(name) { "#dirty => #{result.to_h.keys}" }
            result.to_h
          end

          def dirty_ids
            dirty.keys
          end

          def merge(key, old, new)
            logger.debug(name) { "#merge(#{key},#{old.char_array},#{new})" }
            if old.char_array == new
              logger.debug(name) { "Field #{key}: no change!" }
              old
            elsif new.is_a?(Array) || new.is_a?(Core::Bytes)
              return old if new.empty?
              new_value = Value.new(new, dirty: true)
              logger.debug(name) { "Field #{key}: modified! (\"#{old}\" -> \"#{new_value}\")" }
              new_value
            else
              logger.warn(name) { "#merge: I don't like: #{new.class}: #{new}" }
              old
            end
          rescue StandardError => e
            LOGGER.error(name) { e }
            e.backtrace.each do |line|
              LOGGER.error(name) { line }
            end
          end
        end
      end
    end
  end
end
