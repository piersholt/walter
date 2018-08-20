module Register
  # PATH = './devices.yaml'
  # register

  def key_to_path(register_key)
    "./#{register_key}.yaml"
  end

  def register
    @@register ||= {}
  end

  def setup_register(register_key)
    unless register[register_key].nil?
      # LOGGER.debug 'Register is already setup!'
      return false
    end

    # binding.pry if register_key == :command

    LOGGER.debug "Setup register: #{register_key}"
    file = File.open(key_to_path(register_key))
    yaml_buffer = file.read
    yaml_data = YAML.load(yaml_buffer)
    yaml_data = {} if yaml_data == false
    register[register_key] = yaml_data
    true
  end

  def update_register(register_key, args = {})
    # Notify is used for both exiting and new data
    # if args.key?(:exit)
    #   close_register(register_key)
    #   return false
    # end

    create(register_key, args[:id], args)

    true
  end

  def close_register(register_key)
    LOGGER.debug 'Close register'
    begin
      if register[register_key].nil?
        LOGGER.debug 'Register is already nil!'
        return false
      end

      # Reorder hash
      cur_reg = register[register_key]
      new_reg = {}
      (0..255).each do |i|
        new_reg[i] = cur_reg[i] if cur_reg.key?(i)
      end
      register[register_key] = new_reg

      yaml_buffer = YAML.dump(register[register_key])

      file = File.open(key_to_path(register_key), 'w')
      file.write_nonblock(yaml_buffer)

      register[register_key] = nil

      return true
    rescue Exception => e
      LOGGER.error e
      e.backtrace.each { |b| LOGGER.error b }
    end
  end

  def lookup(register_key, key)
    # LOGGER.debug("Register / Lookup / #{register_key}: #{key}")
    setup_register(register_key)
    specific_register = register[register_key]
    serialized_object = specific_register[key]

    if serialized_object.nil?
      LOGGER.debug "#{register_key} with id #{key} not found!"
      return nil
      # fail IndexError, "Device with address #{key} not found!"
    end

    begin
      serialized_object.created_at=DateTime.now if serialized_object.created_at.nil?
      serialized_object.updated_at=DateTime.now if serialized_object.updated_at.nil?
    rescue StandardError => e
      binding.pry
    end
    # result[:updated_at] = DateTime.now if result[:updated_at].nil?

    # LOGGER.debug(serialized_object.to_s)
    # LOGGER.debug("Register / Lookup / #{register_key}: #{key} = #{serialized_object.to_s}")
    # puts device_serialized_object.keys
    # puts device_serialized_object.values


    # device = Device.new(device_serialized_object[:id])
    #
    # device_serialized_object.each do |k,v|
    #   device.public_send("#{k}=", v)
    # end

    serialized_object
  end

  def create(register_key, key, object)
    LOGGER.debug("#{self}#create(#{register_key}, #{key}, #{object.inspect})")
    setup_register(register_key)
    # return false if duplicate?(register_key, key)

    LOGGER.info("Update #{register_key} ID: #{key}")

    register[register_key][key] = object

    true
  end

  def duplicate?(register_key, key)
    duplicate = register[register_key].key?(key)
    # LOGGER.warn('Device already ')

    duplicate
  end
end
