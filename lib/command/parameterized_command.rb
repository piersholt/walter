class Command
  class ParameterizedCommand < BaseCommand
    def to_s
      str_buffer = "#{sn}\t"

      str_buffer << format_thing
    end

    def format_thing
      parameters.map do |param|
        param_name = param
        param_object = public_send(param)
        value = param_object.value
        value = value.kind_of?(Numeric) ? d2h(value, true) : value
        "#{param_name}: #{value} (#{param_object.to_s})"
      end.join(' / ')
    end

    def inspect
      return to_s
    end
  end
end
