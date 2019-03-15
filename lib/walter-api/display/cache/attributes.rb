# frozen_string_literal: true

class Vehicle
  class Display
    class Cache
      # Comment
      module Attributes
        extend Forwardable

        def logger
          LogActually.display
        end

        def name
          self.class.name
        end

        # def to_s
        # end

        # def inspect
        #   "<>"
        # end

        FORWARD_MESSAGES = %i[
          << push first last each empty? size sort_by length
          to_s count [] find_all find each_with_index find_index
          map group_by delete_at
        ].freeze

        FORWARD_MESSAGES.each do |fwrd_message|
          def_delegator :attributes, fwrd_message
        end

        attr_reader :attributes

        BLANK_ATTRIBUTE = [].freeze

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
          LogActually.display.error(name) { e }
          e.backtrace.each do |line|
            LogActually.display.error(name) { line }
          end
        end

        def overwrite!(delta_hash)
          LogActually.display.debug(name) { "#overwrite!(#{delta_hash})" }
          attributes.merge!(delta_hash) do |_, _, new_value|
            Value.new(new_value, dirty: false)
          end
        end

        alias attributes! cache!
        alias write! cache!

        # def write!(delta_hash)
        #   LogActually.display.debug(name) { "#write!(#{delta_hash})" }
        #   cache!(delta_hash)
        #   # dirty
        # end

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
          # logger.debug(name) { "#merge(#{key},#{old.char_array},#{new})" }
          if old.char_array == new
            # logger.debug(name) { "old.char_array == new => #{old.char_array == new}" }
            # logger.debug(name) { "Field #{key}: no change!" }
            old
          elsif new.is_a?(Array)
            return old if new.empty?
            new_value = Value.new(new, dirty: true)
            logger.debug(name) { "Field #{key}: modified! (\"#{old}\" -> \"#{new_value}\")" }
            new_value
          else
            logger.warn(name) { "#merge: I don't like: #{new}" }
            old
          end
        rescue StandardError => e
          LogActually.display.error(name) { e }
          e.backtrace.each do |line|
            LogActually.display.error(name) { line }
          end
        end
      end
    end
  end
end
