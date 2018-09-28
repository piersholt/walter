class Command
  class ParameterizedCommand < BaseCommand
    def to_s
      str_buffer = "#{sn}\t"

      str_buffer << parameters.map do |param|
        param_name = param
        param_object = public_send(param)
        "#{param_name}: #{d2h(param_object.value, true)} (#{param_object})"
      end.join(' / ')
    end

    def inspect
      "#<#{self.class} @parameters=#{parameters}>"
    end
  end
end
