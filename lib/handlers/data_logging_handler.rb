class DataLoggingHandler
  include Singleton
  include Event

  # attr_reader :messages

  def self.i
    instance
  end

  def initialize
    @messages = Messages.new
  end

  def inspect
    str_buffer = "<DataLoggingHandler>"
  end

  def update(action, properties)
    case action
    when BUS_ONLINE
      enable_logging
    when BUS_OFFLINE
      disable_logging
    when BYTE_RECEIVED
      log_byte(properties[:read_byte])
    when FRAME_VALIDATED
      log_frame(properties[:frame])
    when EXIT
      close_log_files
    end
  end

  private

  def byte_log
    @log_stream ||= ::File.new("log/#{Time.now.strftime'%F'}.bin",  'a')
  end

  def frame_log
    @log_frames ||= ::File.new("log/#{Time.now.strftime'%F'}.log",  'a')
  end

  def log_byte(next_byte)
    # LOGGER.debug("[Log Handler] #{self.class}#log_byte(#{Byte.new(:encoded, next_byte).to_s(true)})")
    return false unless logging_enabled?
    bytes_written = byte_log.write(next_byte) if logging_enabled?
    LOGGER.debug("[Log Handler] Byte Log: #{bytes_written} bytes written.")
  end

  def log_frame(validated_frame)
    LOGGER.debug("[Log Handler] #{self.class}#log_frame(#{validated_frame})")
    LOGGER.debug("[Log Handler] #{self.class}#logging_enabled? => #{logging_enabled?}")
    return false unless logging_enabled?
    bytes_written = frame_log.write("#{validated_frame}\n") if logging_enabled?
    LOGGER.debug("[Log Handler] Frame Log: #{bytes_written} bytes written.")
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
    LOGGER.warn('[Handler] STREAM logging disabled!')
    @stream_logging = false
  end

  def enable_logging
    LOGGER.info('[Handler] STREAM logging enabled!')
    @stream_logging = true
  end

  def close_log_files
    LOGGER.debug('[Log Handler] disabling logging')
    disable_logging
    LOGGER.warn('[Log Handler] closing log files')
    byte_log.close
    frame_log.close
  end
end
