module API
  module BaseAPI
    include Event
    include Observable
    include ClusterTools
    include LogActually::ErrorOutput

    def name
      'BaseAPI'
    end

    def try(from, to, command_id, command_arguments = {})
      from = DeviceMap.instance.find_by_ident(from)
      to = DeviceMap.instance.find_by_ident(to)
      command_object = to_command(command_id: command_id,
                                  command_arguments: command_arguments,
                                  schema_from: from)

      send_it!(from, to, command_object)
    rescue StandardError => e
      LogActually.api.error("#{self.class} StandardError: #{e}")
      e.backtrace.each { |l| LogActually.api.error(l) }
      binding.pry
    end

    def send_it!(from, to, command)
      LogActually.api.debug(name) { "#send_it!(#{from.sn(false)}, #{to.sn(false)}, #{command.inspect})" }
      message = Message.new(from, to, command)
      changed
      notify_observers(MESSAGE_SENT, message: message)
      true
    rescue StandardError => e
      LogActually.api.error("#{self.class} StandardError: #{e}")
      e.backtrace.each { |l| LogActually.api.error(l) }
      binding.pry
    end

    alias give_it_a_go try

    private

    def to_command(command_id:, command_arguments:, schema_from:)
      command_config = CommandMap.instance.config(command_id, schema_from)
      command_builder = command_config.builder
      command_builder = command_builder.new(command_config)
      command_builder.add_parameters(command_arguments)
      command_builder.result
    rescue StandardError => e
      with_backtrace(LogActually.api, e)
    end

    def format_chars!(command_arguments, opts = { align: :center })
      chars_string = command_arguments[:chars]
      return false unless chars_string

      align(chars_string, opts[:align])

      chars_array = chars_string.bytes
      command_arguments[:chars] = chars_array
    end
  end
end
