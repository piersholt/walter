# frozen_string_literal: true

class Walter
  class UserInterface
    module View
      module Bluetooth
        # Comment
        class Device < BASIC_MENU
          include Constants

          NO_VALUES = [].freeze
          NO_OPTIONS = [].freeze

          VALUES = %i[alias address adapter].freeze
          BOOLEANS = %i[connected?].freeze

          def initialize(device)
            @properties = indexed_values(device)
            @options = indexed_booleans(device)
          end

          def menu_items
            @properties + @options + navigation_item
          end

          def navigation_item
            navigation(index: NAVIGATION_INDEX,
                       action: :bluetooth_index)
          end

          private

          def indexed_values(device)
            return NO_VALUES if VALUES.length.zero?
            validate(VALUES, COLUMN_ONE_MAX)

            VALUES.first(COLUMN_ONE_MAX).map.with_index do |property, index|
              property_value = device.public_send(property)
              thingo = BASE_MENU_ITEM.new(label: property_value)
              [index, thingo]
            end
          end

          def indexed_booleans(device)
            validate(BOOLEANS, COLUMN_TWO_MAX)
            return NO_OPTIONS if BOOLEANS.length.zero?

            BOOLEANS.first(COLUMN_TWO_MAX).map.with_index do |boolean, index|
              offset_index = index + COLUMN_TWO_OFFSET
              thingo =
                if device.pending
                  pending(device.address)
                elsif device.connected?
                  disconnect(device.address)
                elsif device.disconnected?
                  connect(device.address)
                else
                  pending(device.address)
                end
              [offset_index, thingo]
            end
          end

          def connect(id)
            BASE_MENU_ITEM.new(id: id,
                             label: 'Connect',
                             action: :bluetooth_connect)
          end

          def disconnect(id)
            BASE_MENU_ITEM.new(id: id,
                             label: 'Disconnect',
                             action: :bluetooth_disconnect)
          end

          def pending(id)
            BASE_MENU_ITEM.new(id: id,
                             label: 'Please Wait...')
          end

        end
      end
    end
  end
end
