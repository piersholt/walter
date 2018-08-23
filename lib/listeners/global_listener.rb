require 'observer'

require 'message'
require 'event'

require 'handlers/message_handler'

require 'maps/device_map'
require 'maps/command_map'

# TODO this needs to be changed later. I've just chucked everything in a single
# listener for now, but if I can define a standard event notification, i can
# from the single notify_observers(args) call, ensure that the arguments are
# global.
# If the events are universal, i avoid coupling the outcome to event definition
# i.e. don't have statistic events, have events that the statslistener attaches to

# NOTE there's no.. events.. per se, it's... states..
class GlobalListener
  include Observable
  include Event

  def initialize(application_layer)
    # TODO split out
    @stream_logging = nil
    @stats = initialize_stats
    @message_handler = MessageHandler.instance

    @device_map = DeviceMap.instance
    @command_map = CommandMap.instance

    @application_layer = application_layer
    add_observer(self)
  end

  def update(action, properties)
    # LOGGER.debug("[Listener] #{self.class}#update(#{action}, #{properties})")
    raise ::ArgumentError, 'unrecognised action' unless valid?(action)

    begin
      case action
      when EXIT
        LOGGER.warn "[Global Listener] Exiting! Reason: #{properties[:reason]}"
        LOGGER.warn "[Global Listener] Hiding display output..."
        # hide the message output as it clutters the exit log messages
        @message_handler.hide
        LOGGER.warn "[Global Listener] Closing log files..."
        close_log_files
      when BUS_ONLINE
        LOGGER.info("[Global Listener] BUS online!")
        enable_logging
      when BUS_OFFLINE
        LOGGER.warn("[Global Listener] BUS offline!")
        disable_logging
      when BYTE_RECEIVED
        update_stats(BYTE_RECEIVED)
        # debug(BYTE_RECEIVED, properties)
        log_byte(properties[:read_byte])
      when FRAME_VALIDATED
        # binding.pry if LOGGER.sev_threshold == Logger::DEBUG
        # LOGGER.debug("[Listener] #{self.class}#update(#{action}, #{properties})")
        update_stats(FRAME_VALIDATED)
        log_frame(properties[:frame])
        message = process_frame(properties[:frame])

        changed
        notify_observers(MESSAGE_RECEIVED, message: message)
      when FRAME_FAILED
        update_stats(FRAME_FAILED)
      when MESSAGE_RECEIVED
        update_stats(MESSAGE_RECEIVED)
        @message_handler.add_message(properties[:message])
        @application_layer.new_message(properties[:message])
      else
        LOGGER.debug("#{self.class} erm.. #{action} wasn't handled?")
      end
    rescue Exception => e
      LOGGER.error("#{self.class} Exception: #{e}")
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end

  private

  # ************************************************************************* #
  #                                  HANDLERS
  # ************************************************************************* #

  # ------------------------------ STATISTICS ------------------------------ #

  # TODO split out
  METRICS = [BYTE_RECEIVED, FRAME_VALIDATED, FRAME_FAILED, MESSAGE_RECEIVED]

  def initialize_stats
    METRICS.map do |metric|
      [metric, 0]
    end.to_h
  end

  def update_stats(metric)
    @stats[metric] += 1
  end

  # ------------------------------ FRAME ------------------------------ #

  MESSAGE_COMPONENTS = [:from, :to, :command, :arguments].freeze
  FRAME_TO_MESSAGE_MAP = {
    from: { frame_component: :header,
            component_index: 0 },
    to: { frame_component: :tail,
          component_index: 0 },
    command: {  frame_component: :tail,
                component_index: 1 },
    arguments: { frame_component: :tail,
                 component_index: 2..-2 } }.freeze

  def process_frame(frame)
    LOGGER.debug("#{self.class}#process_frame(#{frame})")
    LOGGER.debug frame.inspect

    # FRAME = HEADER, PAYLOAD, FCS
    # MESSAGE = FROM, TO, COMMAND, ARGUMENTS

    from = frame.header[0]
    from = from.to_d
    from = @device_map.find(from)

    to = frame.tail[0]
    to = to.to_d
    to = @device_map.find(to)

    arguments = frame.tail[2..-2]

    command = frame.tail[1]
    command_id = command.to_d
    command = @command_map.find(command_id, arguments)

    Message.new(from, to, command, arguments)
  end

  def debug(action, properties)
    read_byte = properties[:read_byte]
    parsed_byte = properties[:parsed_byte]

    LOGGER.debug "Channel / #{action}: #{parsed_byte}, POS: #{properties[:pos]}"
  end

  # ------------------------------ LOGGING ------------------------------ #

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
