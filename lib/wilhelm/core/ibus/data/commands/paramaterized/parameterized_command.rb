class Wilhelm::Core::Command
  class ParameterizedCommand < BaseCommand
    def to_s
      str_buffer = "#{sn}\t"

      str_buffer << format_things
    end

    def format_things
      result = parameters.map do |param|
        format_thing(param)
      end
      result.join(' / ')
    end

    def format_thing(param)
      param_name = param
      param_object = public_send(param)
      value = param_object.value
      value = value.kind_of?(Numeric) ? d2h(value, true) : value
      "#{param_name}: #{value} (#{param_object.to_s})"
    end

    def inspect
      return to_s
    end
  end
end
