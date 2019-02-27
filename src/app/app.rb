# frozen_string_literal: true

root = 'app'

require 'app/_deprecated/actions'
require 'app/_deprecated/intents'
# require 'app/_deprecated/intent_handler'
# require 'app/_deprecated/intent_listener'

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

require "#{audio_root}/models/player"
require "#{audio_root}/models/target"
require "#{audio_root}/notifications/controller_handler"
require "#{audio_root}/notifications/target_handler"
require "#{audio_root}/states/disabled"
require "#{audio_root}/states/enabled"
require "#{audio_root}/states/on"
require "#{audio_root}/audio"

# Manager
manager_root = services + '/manager'

require "#{manager_root}/models/device"
require "#{manager_root}/models/devices"
require "#{manager_root}/notifications/device_handler"
require "#{manager_root}/states/disabled"
require "#{manager_root}/states/enabled"
require "#{manager_root}/states/on"
require "#{manager_root}/manager"


require "#{root}/states/offline"
require "#{root}/states/establishing"
require "#{root}/states/online"
require "#{root}/service"
