require 'application/virtual/api/key'
require 'application/virtual/api/media'
require 'application/virtual/api/ccm'
require 'application/virtual/api/ike_sensors'
require 'application/virtual/api/speed'
require 'application/virtual/api/lamp'
require 'application/virtual/api/radio_led'
require 'application/virtual/api/radio_gfx'

require 'application/virtual/api/alive'

class BusDevice
  include API::Key
  include API::Media
  include API::CCM
  include API::IKESensors
  include API::Speed
  include API::Lamp
  include API::RadioLED
  include API::RadioGFX
  include API::Alive
end
