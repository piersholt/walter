module API
  module BaseAPI
    include Event
    include Observable

    def give_it_a_go(from_id, to_id, command_id, command_arguments = {})
      begin
        from = DeviceMap.instance.find(from_id)
        to = DeviceMap.instance.find(to_id)

        parameter_value_pairs = command_arguments.map do |parameter, value|
          [parameter, value]
        end

        command = CommandMap.instance.klass(command_id)

        parameter_value_pairs.each do |name_value_pair|
          command.try_set(*name_value_pair)
        end
      rescue StandardError => e
        LOGGER.error("#{self.class} StandardError: #{e}")
        e.backtrace.each { |l| LOGGER.error(l) }
        binding.pry
      end

      deliver(from, to, command)
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
  end
end
