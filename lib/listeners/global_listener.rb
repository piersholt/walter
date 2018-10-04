require 'observer'
require 'event'

require 'handlers/display_handler'
require 'handlers/session_handler'
require 'handlers/data_logging_handler'
require 'datalink/handlers/demultiplexing_handler'
require 'datalink/handlers/multiplexing_handler'
require 'application/handlers/packet_handler'
require 'handlers/bus_handler'
require 'datalink/handlers/transmission_handler'
require 'application/handlers/packet_routing_handler'

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

  PROC = 'GlobalListener'

  def initialize(handlers = {})
    @session_handler = SessionHandler.instance
    @display_handler = DisplayHandler.instance
    @data_logging_handler = DataLoggingHandler.instance
    @demultiplexing_handler = DemultiplexingHandler.instance
    @packet_handler = PacketHandler.instance
    

    @multiplexing_handler = MultiplexingHandler.instance

    @transmission_handler = handlers[:transmission]
    @bus_handler = handlers[:bus]
    @packet_routing_handler = handlers[:packet_routing]

    @demultiplexing_handler.add_observer(self)
    @multiplexing_handler.add_observer(self)
    add_observer(self)
  end

  def update(action, properties = {})
    # LOGGER.debug("[Listener] #{self.class}#update(#{action}, #{properties})")
    validate_event(action)

    begin
      case action
      when EXIT
        exit(action, properties)
      when BUS_ONLINE
        bus_online(action, properties)
      when BUS_OFFLINE
        bus_offline(action, properties)
      when BYTE_RECEIVED
        byte_received(action, properties)
      when FRAME_RECEIVED
        frame_received(action, properties)
      when FRAME_FAILED
        frame_failed(action, properties)
      when MESSAGE_RECEIVED
        message_received(action, properties)
      when PACKET_RECEIVED
        packet_received(action, properties)
      when MESSAGE_SENT
        message_sent(action, properties)
      when FRAME_SENT
        frame_sent(action, properties)
      else
        LOGGER.warn(PROC) { "#{action} not handled?" }
      end
    rescue StandardError => e
      LOGGER.error(PROC) { "#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end

  private

  # ---- APPLICATION --- #

  def message_sent(action, properties)
    @multiplexing_handler.update(action, properties)
  end

  def message_received(action, properties)
    @session_handler.update(action, properties)
    # @display_handler.update(action, properties)
  end

  def packet_received(action, properties)
    # packet = properties[:packet]
    # LOGGER.warn(PROC) { "#{packet}" }
    # LOGGER.warn(PROC) { "Data class: #{packet.data.class}" }
    # LOGGER.warn(PROC) { "Datum class: #{packet.data[0].class}" }
    # @packet_routing_handler.update(action, properties)
    @demultiplexing_handler.update(action, properties)
  end

  # ---- DATALINK --- #

  def frame_sent(action, properties)
    @transmission_handler.update(action, properties)
  end

  def frame_received(action, properties)
    @data_logging_handler.update(action, properties)
    @demultiplexing_handler.update(action, properties)
    @session_handler.update(action, properties)
  end

  def frame_failed(action, properties)
    @session_handler.update(action, properties)
  end

  # ---- PHYSICAL --- #

  def byte_received(action, properties)
    @data_logging_handler.update(action, properties)
    @session_handler.update(action, properties)
  end

  # ---- BUS STATUS --- #

  def bus_offline(action, properties)
    LOGGER.warn(PROC) { 'Bus Offline!' }
    @data_logging_handler.update(action, properties)
    @bus_handler.update(action, properties)
  end

  def bus_online(action, properties)
    LOGGER.info(PROC) { 'Bus Online!' }
    @data_logging_handler.update(action, properties)
  end

  # ---- PROGRAM --- #

  def exit(action, properties)
    LOGGER.info(PROC) {  "Exit: Reason: #{properties[:reason]}" }

    LOGGER.debug(PROC) { "Delegate: #{@display_handler.class}" }
    @display_handler.update(action, properties)
    LOGGER.debug(PROC) { "Delegate: #{@display_handler.class} complete!" }

    LOGGER.debug(PROC) { "Delegate: #{@data_logging_handler.class}" }
    @data_logging_handler.update(action, properties)
    LOGGER.debug(PROC) { "Delegate: #{@data_logging_handler.class} complete!" }
  end
end
