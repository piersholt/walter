require 'api/base_api'

# ignition
# speed

module API
  module Speed
    include BaseAPI

    COMMAND_ID = 0x18
    FROM_DEFAULT = Devices::IKE
    TO_DEFAULT = Devices::GLOL

    def speed(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      begin
        from = DeviceMap.instance.find(from_id)
        to = DeviceMap.instance.find(to_id)

        speed_value = command_arguments[:speed]
        rpm_value = command_arguments[:rpm]


        command = CommandMap.instance.klass(0x18)

        command.try_set(:speed, speed_value)
        command.try_set(:rpm, rpm_value)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end

      deliver(from, to, command)
    end
  end
end
