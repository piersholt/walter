module API
  include Event
  include Observable

  def post(message)
    changed
    notify_observers(MESSAGE_SENT, message: message)
    message
  end
end

module API
  module Media
    include API

    COMMAND_ID = 0x23
    TO_DEFAULT = Devices::GLOH
    FROM_DEFAULT = Devices::RAD

    def update(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      from = DeviceMap.instance.find(from_id)
      to = DeviceMap.instance.find(to_id)
      begin
        gfx_value = command_arguments[:gfx]
        ike_value = command_arguments[:ike]
        chars_value = command_arguments[:chars]

        command = CommandMap.instance.klass(COMMAND_ID)
        command.try_set(:gfx, gfx_value)
        command.try_set(:ike, ike_value)
        command.try_set(:chars, chars_value)

        message = Message.new(from, to, command)
        post(message)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end
  end
end

module API
  module Key
    include API

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
        post(message)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end
  end
end
