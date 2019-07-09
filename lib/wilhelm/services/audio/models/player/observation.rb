# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Player
        # Audio::Player::Observation
        module Observation
          include Observable

          alias add_observer! add_observer
          alias delete_observer! delete_observer

          def add_observer(object, method = nil)
            logger.debug(fuck_off) { "#add_observer(#{object.class}:#{Kernel.format('%#.14x',(object.object_id * 2))})" }
            raise ArgumentError, 'Duplicate!' if
            @observer_peers&.keys&.find do |observer, method|
              observer.class == object.class
            end
            # raise ArgumentError, 'Duplicate!' if @observer_peers&.keys&.include?(object)
            add_observer!(object, method)
          end

          def delete_observer(object)
            logger.debug(fuck_off) { "#delete_observer(#{object.class}:#{Kernel.format('%#.14x',(object.object_id * 2))})" }
            # raise ArgumentError, 'Duplicate!' if @observer_peers&.keys&.include?(object)
            delete_observer!(object)
          end

          def observers
            x = instance_variable_get(:@observer_peers)
            x.map do |observer, method|
              klass = observer.class
              id = Kernel.format('%#.14x',(observer.object_id * 2))
              ["#{klass}:#{id}", method]
            end&.to_h
          end
        end
      end
    end
  end
end
