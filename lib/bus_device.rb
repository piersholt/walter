require 'api/key'
require 'api/media'
require 'api/ccm'
require 'api/ike_sensors'
require 'api/speed'
require 'api/lamp'

class BusDevice
  include API::Key
  include API::Media
  include API::CCM
  include API::IKESensors
  include API::Speed
  include API::Lamp
end
