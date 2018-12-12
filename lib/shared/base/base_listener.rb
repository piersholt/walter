require 'observer'
# require 'event'

class BaseListener
  include Observable
  include Event
end
