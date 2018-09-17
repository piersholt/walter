require 'api/base_api'

module API
  module Key
    include BaseAPI

    COMMAND_ID = 0x74
    TO_DEFAULT = Devices::GLOL
    FROM_DEFAULT = Devices::GLOL

    def state(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      begin
        from = DeviceMap.instance.find(from_id)
        to = DeviceMap.instance.find(to_id)

        status_value = command_arguments[:status]
        key_value = command_arguments[:key]

        command = CommandMap.instance.klass(COMMAND_ID)
        command.try_set(:status, status_value)
        command.try_set(:key, key_value)

        message = Message.new(from, to, command)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end

      post(message)
    end
  end
end
