# require 'application/virtual/api/base_api'

# ignition
# speed

module API
  module IKESensors
    include BaseAPI

    COMMAND_ID = 0x13
    FROM_DEFAULT = Devices::IKE
    TO_DEFAULT = Devices::GLOL

    # @param Array[Integer, 8] bit_array_1
    # @param BitArray bit_array_2
    # @param BitArray bit_array_3
    def sensors(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      command_id = COMMAND_ID
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
