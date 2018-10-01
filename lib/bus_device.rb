require 'api/key'
require 'api/media'
require 'api/ccm'
require 'api/ike_sensors'
require 'api/speed'
require 'api/lamp'
require 'api/radio_led'
require 'api/radio_gfx'


class BusDevice
  include API::Key
  include API::Media
  include API::CCM
  include API::IKESensors
  include API::Speed
  include API::Lamp
  include API::RadioLED
  include API::RadioGFX
end
