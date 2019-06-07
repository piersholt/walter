class BaseHandlerError < StandardError
  def message
    'BaseHandler Erro'
  end
end

class BaseHandler
  include Observable
  include Event
  include Helpers

  def fetch(props, key)
    raise BaseHandlerError, "#{key} is not in properties!" unless props.key?(key)
    object = props[key]
    raise BaseHandlerError, "#{key} is nil!" if object.nil?
    object
  end

  def handle(action, properties)
    begin
      update(action, properties)
    rescue StandardError => e
      LOGGER.error(PROC) { "#{e}" }
      e.backtrace.each { |l| LOGGER.error(l) }
      binding.pry
    end
  end
end

# require '/bus/bus_handler'
