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

# UI
ui_root = root + '/ui'

require "#{ui_root}/layout/header/base_field"
require "#{ui_root}/layout/header/base_header"
require "#{ui_root}/layout/header/default_header"
require "#{ui_root}/layout/header/notification_header"
require "#{ui_root}/layout/menu/base_menu_item"
require "#{ui_root}/layout/menu/base_menu"
require "#{ui_root}/layout/menu/menus"

# require "#{ui_root}/model/bluetooth/device"
# require "#{ui_root}/model/bluetooth/index"
require "#{ui_root}/view/header/audio"

require "#{ui_root}/view/bluetooth/device"
require "#{ui_root}/view/bluetooth/index"

require "#{ui_root}/view/audio/now_playing"
require "#{ui_root}/view/audio/index"

require "#{ui_root}/view/main_menu/index"

require "#{ui_root}/controller/base_controller"
require "#{ui_root}/controller/bluetooth_controller"
require "#{ui_root}/controller/audio_controller"
require "#{ui_root}/controller/header_controller"
require "#{ui_root}/controller/main_menu_controller"

require "#{ui_root}/user_interface"

# SERVICE
# service_root = root + '/service'

require "#{root}/states/offline"
require "#{root}/states/establishing"
require "#{root}/states/online"
require "#{root}/service"

# require "#{root}/node"
