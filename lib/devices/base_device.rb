# this is a comment about a thing?
class Devices
  # Basic device class
  class BaseDevice
    PADDED_DEFAULT = true

    attr_accessor :id, :short_name, :long_name

    alias :address :id
    # alias :sn :short_name
    alias :ln :long_name

    def initialize(id, props)
      LOGGER.debug("BaseDevice") { "#initialize(#{id}, #{props})" }
      @id = id
      parse_properties(props)
    end

    def desc
      buffer = "#{@sn}: #{@ln}"
      buffer
    end

    def d
      @id[:d]
    end

    def sn(padded = PADDED_DEFAULT)
      padded ? sprintf("%-6s", short_name) : short_name
    end

    def h
      DataTools.decimal_to_hex(d)
    end

    def to_s
      return inspect if @verbose
      "#{@id[:h]}: #{@short_name} / #{@long_name}"
    end

    def inspect
      # "<BaseDevice> #{to_s}"
      h
    end

    private

    def parse_properties(props)
      props.each do |name, value|
        instance_variable_set(inst_var(name), value)
      end
    end

    def inst_var(name)
      name_string = name.id2name
      '@'.concat(name_string).to_sym
    end
  end
end
