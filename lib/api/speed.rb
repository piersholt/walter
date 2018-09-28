require 'api/base_api'

# ignition
# speed

module API
  module Speed
    include BaseAPI

    COMMAND_ID = 0x18
    FROM_DEFAULT = Devices::IKE
    TO_DEFAULT = Devices::GLOL

    # @param Integer rpm (actual/100. e.g. 2000rpm = 200)
    # @param Integer speed (actual/2. e.g. 60kmph = 30)
    def speed(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      command_id = COMMAND_ID
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
