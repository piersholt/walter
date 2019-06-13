
# require 'event'

# require 'handlers/base_handler'

# TODO this needs to be changed later. I've just chucked everything in a single
# listener for now, but if I can define a standard event notification, i can
# from the single notify_observers(args) call, ensure that the arguments are
# global.
# If the events are universal, i avoid coupling the outcome to event definition
# i.e. don't have statistic events, have events that the statslistener attaches to

# NOTE there's no.. events.. per se, it's... states..
class Wilhelm::Core::GlobalListener
  include Observable
  include Wilhelm::Core::Event

  PROC = 'GlobalListener'

  def initialize(handlers = {})
    # @intent_listener = handlers[:intent]
  end

  def name
    self.class.name
  end

  def update(action, properties = {})
    # LOGGER.debugrate (name) { "#update(#{action}, #{properties})" }
    return false unless event_valid?(action)

    begin
      case action
      when EXIT
        LOGGER.debug(PROC) {  "Exit: Reason: #{properties[:reason]}" }
      when BUS_ONLINE
        LOGGER.debug(PROC) { 'Bus Online!' }
      when BUS_OFFLINE
        LOGGER.debug(PROC) { 'Bus Offline!' }
      when MESSAGE_SENT
        LOGGER.debug(PROC) { MESSAGE_SENT }
      when PACKET_RECEIVED
        LOGGER.debug(PROC) { PACKET_RECEIVED }
      when PACKET_ROUTABLE
        LOGGER.debug(PROC) { PACKET_ROUTABLE }
      when FRAME_SENT
        LOGGER.debug(PROC) { FRAME_SENT }
      when FRAME_RECEIVED
        LOGGER.debug(PROC) { FRAME_RECEIVED }
      when BYTE_RECEIVED
        LOGGER.debug(PROC) { BYTE_RECEIVED }
      when MESSAGE_RECEIVED
        LOGGER.debug(PROC) { MESSAGE_RECEIVED }
      end
    rescue StandardError => e
      LOGGER.error(PROC) { "#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end
end
