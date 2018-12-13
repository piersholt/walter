
# require 'event'

# require 'handlers/base_handler'

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
    # @intent_listener = handlers[:intent]
  end

  def name
    self.class.name
  end

  def update(action, properties = {})
    # LOGGER.unknownrate (name) { "#update(#{action}, #{properties})" }
    return false unless event_valid?(action)

    begin
      case action
      when EXIT
        LOGGER.unknown(PROC) {  "Exit: Reason: #{properties[:reason]}" }
      when BUS_ONLINE
        LOGGER.unknown(PROC) { 'Bus Online!' }
      when BUS_OFFLINE
        LOGGER.unknown(PROC) { 'Bus Offline!' }
      when PACKET_RECEIVED
        LOGGER.unknown(PROC) { PACKET_RECEIVED }
      when PACKET_ROUTABLE
        LOGGER.unknown(PROC) { PACKET_ROUTABLE }
      when FRAME_SENT
        LOGGER.unknown(PROC) { FRAME_SENT }
      when FRAME_RECEIVED
        LOGGER.unknown(PROC) { FRAME_RECEIVED }
      when BYTE_RECEIVED
        LOGGER.unknown(PROC) { BYTE_RECEIVED }
      when MESSAGE_RECEIVED
        LOGGER.unknown(PROC) { MESSAGE_RECEIVED }
      end
    rescue StandardError => e
      LOGGER.error(PROC) { "#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end
end
