# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GFX
        module Capabilities
          module OnBoardComputer
            # OBC Interface: Distance
            module Distance
              include API
              include Constants

              def distance?
                obc_bool(field: FIELD_DISTANCE, control: CONTROL_REQUEST)
              end

              # Distance Value
              def input_distance(distance)
                return false unless valid_distance?(distance)
                obc_var(
                  b1: FIELD_DISTANCE, b2: VAR_NIL,
                  b3: distance, b4: VAR_NIL
                )
              end

              private

              def valid_distance?(distance)
                return false unless distance.is_a?(Integer)
                # You need to deal with b2 if you want larger distance
                return false if distance > 0b1111_1111
                return false if distance.negative?
                true
              end
            end
          end
        end
      end
    end
  end
end
