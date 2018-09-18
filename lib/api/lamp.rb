require 'api/base_api'

# ignition
# speed

module API
  module Lamp
    include BaseAPI

    COMMAND_ID = 0x5B
    FROM_DEFAULT = Devices::LCM
    TO_DEFAULT = Devices::GLOL

    def lamp(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      begin
        from = DeviceMap.instance.find(from_id)
        to = DeviceMap.instance.find(to_id)

        byte1_value = command_arguments[:byte1]
        byte2_value = command_arguments[:byte2]
        byte3_value = command_arguments[:byte3]
        byte4_value = command_arguments[:byte4]

        command = CommandMap.instance.klass(COMMAND_ID)
        command.try_set(:byte1, byte1_value)
        command.try_set(:byte2, byte2_value)
        command.try_set(:byte3, byte3_value)
        command.try_set(:byte4, byte4_value)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end

      deliver(from, to, command)
    end
  end
end
