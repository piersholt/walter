require 'observer'
require 'event'

require 'handlers/display_handler'
require 'handlers/session_handler'
require 'handlers/data_logging_handler'
require 'handlers/frame_handler'



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
    @session_handler = SessionHandler.instance
    @display_handler = DisplayHandler.instance
    @data_logging_handler = DataLoggingHandler.instance
    @frame_handler = FrameHandler.instance
    @frame_handler.add_observer(self)

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
        @display_handler.update(action, properties)
        LOGGER.warn "[Global Listener] Closing log files..."
        @data_logging_handler.update(action, properties)
      when BUS_ONLINE
        LOGGER.info("[Global Listener] BUS online!")
        @data_logging_handler.update(action, properties)
      when BUS_OFFLINE
        LOGGER.warn("[Global Listener] BUS offline!")
        @data_logging_handler.update(action, properties)
      when BYTE_RECEIVED
        @data_logging_handler.update(action, properties)
      when FRAME_VALIDATED
        @data_logging_handler.update(action, properties)
        @frame_handler.update(action, properties)
      when FRAME_FAILED
        @session_handler.update(action, properties)
      when MESSAGE_RECEIVED
        @session_handler.update(action, properties)
        @display_handler.update(action, properties)
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
end
