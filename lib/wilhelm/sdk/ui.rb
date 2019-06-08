# frozen_string_literal: true

puts "\tLoading wilhelm/sdk/ui"

require_relative 'ui/constants'

# Models
puts "\tLoading wilhelm/sdk/ui/model"

require_relative 'ui/model/base_list'

# Views
puts "\tLoading wilhelm/sdk/ui/view"

# Base
require_relative 'ui/view/header/base_field'
require_relative 'ui/view/header/base_header'
require_relative 'ui/view/header/default_header'
require_relative 'ui/view/header/notification_header'

require_relative 'ui/view/menu/base_menu_item'
require_relative 'ui/view/menu/checked_item'
require_relative 'ui/view/menu/base_menu'
require_relative 'ui/view/menu/basic_menu'
require_relative 'ui/view/menu/titled_menu'
require_relative 'ui/view/menu/static_menu'

# Application Context
require_relative 'ui/view/header/status'
require_relative 'ui/view/debug/index'
require_relative 'ui/view/nodes/index'
require_relative 'ui/view/services/index'
require_relative 'ui/view/characters/index'

# Controllers
puts "\tLoading wilhelm/sdk/ui/controller"

# Base
require_relative 'ui/controller/base_controller'

# Application Context
require_relative 'ui/controller/header_controller'
require_relative 'ui/controller/debug_controller'
require_relative 'ui/controller/nodes_controller'
require_relative 'ui/controller/services_controller'
require_relative 'ui/controller/characters_controller'

# Context
puts "\tLoading wilhelm/sdk/ui/controller"

require_relative 'ui/context'
