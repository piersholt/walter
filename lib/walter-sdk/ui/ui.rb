# frozen_string_literal: true

puts "\tLoading walter-sdk/ui"

require_relative 'constants'

# Views
puts "\tLoading walter-sdk/ui/view"

# Base
require_relative 'view/header/base_field'
require_relative 'view/header/base_header'
require_relative 'view/header/default_header'
require_relative 'view/header/notification_header'

require_relative 'view/menu/base_menu_item'
require_relative 'view/menu/base_menu'
require_relative 'view/menu/basic_menu'
require_relative 'view/menu/titled_menu'
require_relative 'view/menu/static_menu'

# Application Context
require_relative 'view/header/status'
require_relative 'view/debug/index'
require_relative 'view/nodes/index'
require_relative 'view/services/index'

# Controllers
puts "\tLoading walter-sdk/ui/controller"

# Base
require_relative 'controller/base_controller'

# Application Context
require_relative 'controller/header_controller'
require_relative 'controller/debug_controller'
require_relative 'controller/nodes_controller'
require_relative 'controller/services_controller'

# Context
puts "\tLoading walter-sdk/ui/controller"

require_relative 'context'
