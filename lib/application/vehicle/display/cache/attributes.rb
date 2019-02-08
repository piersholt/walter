# frozen_string_literal: true

class Vehicle
  class Display
    class Cache
      # Comment
      module Attributes
        extend Forwardable

        FORWARD_MESSAGES = %i[
          << push first last each empty? size sort_by length
          to_s count [] find_all find each_with_index find_index
          map group_by delete_at
        ].freeze

        FORWARD_MESSAGES.each do |fwrd_message|
          def_delegator :attributes, fwrd_message
        end

        attr_reader :attributes

        def generate_attributes(length = 10)
          Array.new(length) { |i| [i, []] }.to_h
        end

        def [](index)
          attributes[index]
        end

        def attributes!(delta_hash)
          attributes.merge!(delta_hash) do |key, old, new|
            squish(key, old, new)
          end
        rescue StandardError => e
          LogActually.display.error(self.class.name) { e }
          e.backtrace.each do |line|
            LogActually.display.error(self.class.name) { line }
          end
        end

        def squish(key, old, new)
          if old.is_a?(Hash)
            sqush(key, old, new)
          elsif new.is_a?(String)
            new.encode(Encoding::ASCII_8BIT,
                       Encoding::UTF_8,
                       undef: :replace,
                       replace: 130.chr)
          else
            new
          end
        rescue StandardError => e
          LogActually.display.error(self.class.name) { e }
          e.backtrace.each do |line|
            LogActually.display.error(self.class.name) { line }
          end
        end
      end
    end
  end
end
