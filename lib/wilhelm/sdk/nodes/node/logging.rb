# frozen_string_literal: true

module Wilhelm
  module SDK
    class Node
      # Comment
      module Logging
        include Constants

        attr_reader :nickname

        # def self.included(mod)
        #   puts "#{mod} is including #{self.name}"
        # end

        def to_s
          "#{nickname} (#{state_string})"
        end

        def state_string
          case state
          when Online
            'Online'
          when Establishing
            'Establishing'
          when Offline
            'Offline'
          else
            state.class
          end
        end

        def logger
          LOGGER
        end
      end
    end
  end
end
