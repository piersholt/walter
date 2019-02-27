# frozen_string_literal: true

puts "\tLoading walter-virtual/device/api"

root = 'device/api'

require "#{root}/base_api"
require "#{root}/alive"
require "#{root}/ready"
require "#{root}/cd"
require "#{root}/cd_changer"
require "#{root}/led"
require "#{root}/display"
require "#{root}/radio_led"
require "#{root}/telephone"
require "#{root}/diagnostics"
require "#{root}/bmbt"
require "#{root}/radio"
require "#{root}/gfx"
require "#{root}/obc"
# require "#{root}/ccm"
# require "#{root}/ike_sensors"
# require "#{root}/key"
# require "#{root}/lamp"
# require "#{root}/monitor"
# require "#{root}/radio_gfx"
# require "#{root}/speed"
