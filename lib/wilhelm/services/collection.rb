# frozen_string_literal: true

module Wilhelm
  module Services
    # Services::Collection
    class Collection
      extend Forwardable
      include Observable

      def logger
        LOGGER
      end

      PROG = 'Collection'

      %i[first last each map size length count empty? find_all].each do |method_name|
        def_delegator :values, method_name
      end

      # @param String device_path "/org/bluez/hci0/dev_4C_8D_79_8C_A0_94"
      def find_by_id(id)
        logger.debug(PROG) { "#find_by_id(#{id})" }
        invalid_id(id) unless id.is_a?(String)
        result = objects.fetch(id, false)
        logger.debug(PROG) { "#find => #{result}" }
        result
      end

      alias id find_by_id

      def find_by_id?(id)
        objects.key?(id)
      end

      alias id? find_by_id?

      # @param Object object Collection Klass
      def find_by_object(other_object)
        logger.debug(PROG) { "#find_by_object(#{other_object})" }
        invalid_other_object(other_object) unless other_object.is_a?(klass)
        objects.fetch(other_object.id, false)
      end

      alias object find_by_object

      def find_by_object?(other_object)
        logger.debug(PROG) { "#find_by_object?(#{other_object})" }
        raise(ArgumentError, "#{other_object.class} does not respond to :id!") unless other_object.respond_to?(:id)
        id?(other_object.id)
      end

      alias object? find_by_object?

      def create_or_update(attributes_hash)
        new_object = klass.new(attributes_hash)
        case find_by_object?(new_object)
        when true
          updated_object = find_by_object(new_object)
          updated_object.attributes!(new_object)
          updated_object
        when false
          created_object = add_object(new_object)
          created_object
        end
      end

      def add_object(object_to_add)
        logger.debug(PROG) { "#add_object(#{object_to_add})" }
        object_to_add.add_observer(self, update_method)
        id = object_to_add.id
        objects[id] = object_to_add
      end

      def remove_object(id)
        logger.debug(PROG) { "#remove_object(#{id})" }
        objects.delete(id)
      end

      def one?
        objects.size == 1
      end

      def any?
        objects.any?
      end

      def objects
        @objects ||= {}
      end

      def ids
        objects.keys
      end

      def values
        objects.values
      end

      alias all  values
      alias list values

      def invalid_id(id)
        raise(ArgumentError, "#find: #{id} is not a String!")
      end

      def invalid_other_object(object)
        raise(ArgumentError, "#find_by_object: #{object} is not a #{klass}!")
      end

      def update_method
        raise(StandardError, '#update_method must be overridden!')
      end

      def klass
        raise(StandardError, '#klass must be overridden!')
      end
    end
  end
end
