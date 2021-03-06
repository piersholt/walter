# frozen_string_literal: true

module Wilhelm
  module API
    class Display
      class Cache
        # API::Display::Cache::Base
        class Base
          extend Forwardable

          def_delegators(
            :attributes, :<<, :push, :first, :last, :each, :empty?, :size,
            :sort_by, :to_s, :count, :[], :find_all, :find, :each_with_index,
            :find_index, :map, :group_by, :delete_at
          )

          BLANK_ATTRIBUTE = [].freeze
          NAME = 'Cache::Base'

          attr_reader :attributes

          def initialize(length, offset)
            @attributes = generate_attributes(length, offset)
          end

          def dirty
            attributes.find_all { |_, value| value.dirty }&.to_h
          end

          def dirty_ids
            dirty.keys
          end

          def expired?
            result = attributes.all? { |_, value| value.dirty }
            logger.debug(name) { "#expired? => #{result}" }
            result
          end

          def clear!
            @attributes = generate_attributes(length, index_start)
          end

          def pending!(delta_hash)
            logger.debug(name) { "#pending!(#{delta_hash})" }
            attributes.merge!(delta_hash) do |key, old_value, new_value|
              merge(key, old_value, new_value)
            end
          end

          def write!(delta_hash)
            logger.debug(name) { "#write!(#{delta_hash})" }
            attributes.merge!(delta_hash) do |_, _, new_value|
              Value.new(new_value, dirty: false)
            end
            delta_hash.keys.each do |key|
              next unless attributes.key?(key)
              logger.debug(name) do
                "Field #{key}: written! (\"#{attributes[key]}\")"
              end
            end
          end

          private

          def merge(key, old, new)
            logger.debug(name) { "#merge(#{key},#{old.char_array},#{new})" }
            if old.char_array == new
              logger.debug(name) { "Field #{key}: no change!" }
              old
            elsif new.is_a?(Array) || new.is_a?(Core::Bytes)
              return old if new.empty?
              new_value = Value.new(new, dirty: true)
              logger.debug(name) do
                "Field #{key}: modified! (\"#{old}\" -> \"#{new_value}\")"
              end
              new_value
            else
              logger.warn(name) { "#merge: I don't like: #{new.class}: #{new}" }
              old
            end
          rescue StandardError => e
            logger.error(name) { e }
            e.backtrace.each { |line| logger.error(name) { line } }
          end

          protected

          def generate_attributes(length = 10, offset = 0)
            Array.new(length) { |i| [i + offset, Value.new] }.to_h
          end

          def logger
            LOGGER
          end

          def name
            self.class.const_get(:NAME)
          end

          def length
            self.class.const_get(:LENGTH)
          end

          def index_start
            self.class.const_get(:INDEX_START)
          end
        end
      end
    end
  end
end
