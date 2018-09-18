require 'api/base_api'

module API
  module Media
    include BaseAPI

    COMMAND_ID = 0x23
    TO_DEFAULT = Devices::GLOH
    FROM_DEFAULT = Devices::RAD

    def update(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      begin
        from = DeviceMap.instance.find(from_id)
        to = DeviceMap.instance.find(to_id)

        gfx_value = command_arguments[:gfx]
        ike_value = command_arguments[:ike]
        chars_value = command_arguments[:chars]

        command = CommandMap.instance.klass(COMMAND_ID)
        command.try_set(:gfx, gfx_value)
        command.try_set(:ike, ike_value)
        command.try_set(:chars, chars_value)

        # message = Message.new(from, to, command)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end

      post(from, to, command)
    end
  end
end
