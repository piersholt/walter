require 'api/base_api'

module API
  module CCM
    include BaseAPI

    HUD_SIZE = 20

    COMMAND_ID = 0x1A
    TO_DEFAULT = Devices::IKE
    FROM_DEFAULT = Devices::CCM

    # @param Mode
    # @param Control
    def alert(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      begin
        from = DeviceMap.instance.find(from_id)
        to = DeviceMap.instance.find(to_id)

        command = CommandMap.instance.klass(COMMAND_ID)

        mode_value = command_arguments[:mode]
        command.try_set(:mode, mode_value)

        control_value = command_arguments[:control]
        command.try_set(:control, control_value)

        if command_arguments.key?(:chars)
          chars_string = command_arguments[:chars]
          chars_string = chars_string.center(HUD_SIZE)
          chars_string = chars_string.upcase
          chars_value = chars_string.bytes
          command.try_set(:chars, chars_value)
        end


        # message = Message.new(from, to, command)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end

      deliver(from, to, command)
    end
  end
end
