class DataLoggingHandler < BaseHandler
  include Singleton

  def self.i
    instance
  end

  def name
    self.class.name
  end

  def inspect
    str_buffer = "<DataLoggingHandler>"
  end

  def update(action, properties)
    # LOGGER.unknown(name) { "\t#update(#{action}, #{properties})" }
    case action
    when BYTE_RECEIVED
      read_byte = fetch(properties, :read_byte)
      log_byte(read_byte)
    when FRAME_RECEIVED
      frame = fetch(properties, :frame)
      log_frame(frame)
    when BUS_ONLINE
      LOGGER.info(name) { 'Bus Online! Enable logging.' }
      enable_logging
    when BUS_OFFLINE
      # LOGGER.warn(name) { BUS_OFFLINE }
      LOGGER.warn(name) { 'Bus Offline! Disbaling logging.' }
      disable_logging
    when EXIT
      LOGGER.info(name) { 'Exit: Closing log files.' }
      close_log_files
    end
  rescue StandardError => e
    LOGGER.error(name) { e }
    e.backtrace.each { |line| LOGGER.error(line) }
  end

  private

  def byte_log
    @log_stream ||= ::File.new("log/#{Time.now.strftime'%F'}.bin",  'a')
  end

  def frame_log
    @log_frames ||= ::File.new("log/#{Time.now.strftime'%F'}.log",  'a')
  end

  def log_byte(next_byte)
    # LOGGER.debug("#{self.class}#log_byte(#{Byte.new(:encoded, next_byte).to_s(true)})")
    return false unless logging_enabled?
    bytes_written = byte_log.write(next_byte) if logging_enabled?
    # LOGGER.debug("Byte Log: #{bytes_written} bytes written.")
  end

  def log_frame(validated_frame)
    LOGGER.debug(name) { "#{self.class}#log_frame(#{validated_frame})" }
    LOGGER.debug(name) { "#{self.class}#logging_enabled? => #{logging_enabled?}" }
    return false unless logging_enabled?
    bytes_written = frame_log.write("#{validated_frame}\n") if logging_enabled?
    LOGGER.debug(name) { "Frame Log: #{bytes_written} bytes written." }
  end

  def logging_enabled?
    if @stream_logging == false
      return false
    elsif @stream_logging.nil?
      raise StandardError, 'no logging preference...'
    elsif @stream_logging == true
      return true
    end
  end

  def disable_logging
    LOGGER.debug(name) { 'Logging disabled!' }
    @stream_logging = false
  end

  def enable_logging
    LOGGER.debug(name) { 'Logging enabled!' }
    @stream_logging = true
  end

  def close_log_files
    disable_logging
    LOGGER.debug(name) { "Closing binary stream log #{byte_log.path}." }
    byte_log.close
    LOGGER.info(name) { "#{byte_log.path} closed." }
    LOGGER.debug(name) { "Closing frame log #{frame_log.path}." }
    frame_log.close
    LOGGER.info(name) { "#{frame_log.path} closed." }
  end
end