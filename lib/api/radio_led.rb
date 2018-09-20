require 'api/base_api'

module API
  module RadioLED
    include BaseAPI

    COMMAND_ID = 0x4A
    TO_DEFAULT = Devices::BMBT
    FROM_DEFAULT = Devices::RAD

    def switch(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      begin
        from = DeviceMap.instance.find(from_id)
        to = DeviceMap.instance.find(to_id)

        led_value = command_arguments[:led]

        command = CommandMap.instance.klass(COMMAND_ID)
        command.try_set(:led, led_value)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end

      deliver(from, to, command)
    end
  end
end
