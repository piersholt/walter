# frozen_string_literal: true

root = 'wolfgang'

require 'wolfgang/_deprecated/actions'
require 'wolfgang/_deprecated/intents'

require "#{root}/logger"

# NOTIFICATIONS
notifications_root = root + '/notifications'

require "#{notifications_root}/states/inactive"
require "#{notifications_root}/states/active"

require "#{notifications_root}/listener"

require "#{notifications_root}/service"

# SERVICES
services = root + '/services'

# Audio
audio_root = services + '/audio'

require "#{audio_root}/notifications/controller_handler"

require "#{audio_root}/states/disabled"
require "#{audio_root}/states/enabled"
require "#{audio_root}/states/on"

require "#{services}/audio"

# Manager
manager_root = services + '/manager'

require "#{manager_root}/notifications/device_handler"

require "#{services}/manager"

# SERVICE
service_root = root + '/service'

require "#{service_root}/states/offline"
require "#{service_root}/states/establishing"
require "#{service_root}/states/online"

require "#{root}/service"
