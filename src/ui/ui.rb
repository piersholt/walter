# frozen_string_literal: true

root = 'ui'

# UI
ui_root = root

# require "#{ui_root}/layout/header/base_field"
# require "#{ui_root}/layout/header/base_header"
# require "#{ui_root}/layout/header/default_header"
# require "#{ui_root}/layout/header/notification_header"
# require "#{ui_root}/layout/menu/base_menu_item"
# require "#{ui_root}/layout/menu/base_menu"
# require "#{ui_root}/layout/menu/menus"
# require "#{ui_root}/layout/menu/basic_menu"
# require "#{ui_root}/layout/menu/titled_menu"
# require "#{ui_root}/layout/menu/static_menu"

# require "#{ui_root}/model/bluetooth/device"
# require "#{ui_root}/model/bluetooth/index"
require "#{ui_root}/view/header/audio"
require "#{ui_root}/view/header/status"

require "#{ui_root}/view/bluetooth/device"
require "#{ui_root}/view/bluetooth/index"

require "#{ui_root}/view/audio/now_playing"
require "#{ui_root}/view/audio/index"

require "#{ui_root}/view/main_menu/index"

# require "#{ui_root}/controller/base_controller"
require "#{ui_root}/controller/header_controller"
require "#{ui_root}/controller/bluetooth_controller"
require "#{ui_root}/controller/audio_controller"
require "#{ui_root}/controller/debug_controller"

require "#{ui_root}/user_interface"

# SERVICE
# service_root = root + '/service'

# require "#{root}/node"
