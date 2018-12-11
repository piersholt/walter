module API
  module BaseAPI
    include Event
    include Observable
    include ClusterTools

    def give_it_a_go(from_id, to_id, command_id, command_arguments = {})
      begin
        from = DeviceMap.instance.find(from_id)
        to = DeviceMap.instance.find(to_id)

        command_config = CommandMap.instance.config(command_id)
        command_builder = command_config.builder
        command_builder = command_builder.new(command_config)
        command_builder.add_parameters(command_arguments)
        command_object = command_builder.result
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end

      deliver(from, to, command_object)
    end

    def deliver(from, to, command)
      begin
        message = Message.new(from, to, command)
        send_message(message)
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end

    def send_message(message)
      begin
        changed
        notify_observers(MESSAGE_SENT, message: message)
        message
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end
    end

    private

    def format_chars!(command_arguments, opts = { align: :center })
      chars_string = command_arguments[:chars]
      return false unless chars_string

      align(chars_string, opts[:align])

      chars_array = chars_string.bytes
      command_arguments[:chars] = chars_array
    end
  end
end
