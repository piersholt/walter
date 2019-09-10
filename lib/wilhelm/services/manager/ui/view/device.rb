# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class UserInterface
        module View
          # Manager::UserInterface::View::Device
          class Device < SDK::UIKit::View::BasicMenu
            include SDK::UIKit::View

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
              navigation(
                index: NAVIGATION_INDEX,
                action: :bluetooth_index
              )
            end

            def reinitialize(device)
              @properties = indexed_values(device)
              @options = indexed_booleans(device)
            end

            private

            def indexed_values(device)
              return NO_VALUES if VALUES.length.zero?
              validate(VALUES, COLUMN_ONE_MAX)

              VALUES.first(COLUMN_ONE_MAX).map.with_index do |property, index|
                property_value = device.public_send(property)
                thingo = BaseMenuItem.new(label: property_value)
                [index, thingo]
              end
            end

            def indexed_booleans(device)
              validate(BOOLEANS, COLUMN_TWO_MAX)
              return NO_OPTIONS if BOOLEANS.length.zero?

              BOOLEANS.first(COLUMN_TWO_MAX).map.with_index do |boolean, index|
                offset_index = index + COLUMN_TWO_OFFSET
                thingo =
                if device.pending?
                  pending(device.id)
                elsif device.connected?
                  disconnect(device.id)
                elsif device.disconnected?
                  connect(device.id)
                else
                  pending(device.id)
                end
                [offset_index, thingo]
              end
            end

            def connect(id)
              BaseMenuItem.new(
                id: id,
                label: 'Connect',
                action: :bluetooth_connect
              )
            end

            def disconnect(id)
              BaseMenuItem.new(
                id: id,
                label: 'Disconnect',
                action: :bluetooth_disconnect
              )
            end

            def pending(id)
              BaseMenuItem.new(
                id: id,
                label: 'Please Wait...'
              )
            end
          end
        end
      end
    end
  end
end
