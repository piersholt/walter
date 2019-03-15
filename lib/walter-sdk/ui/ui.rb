# frozen_string_literal: true

puts "\tLoading walter-sdk/ui"

# Views
puts "\tLoading walter-sdk/ui/view"

require_relative 'view/header/base_field'
require_relative 'view/header/base_header'
require_relative 'view/header/default_header'
require_relative 'view/header/notification_header'

require_relative 'view/menu/base_menu_item'
require_relative 'view/menu/base_menu'
require_relative 'view/menu/basic_menu'
require_relative 'view/menu/titled_menu'
require_relative 'view/menu/static_menu'

# Controllers
puts "\tLoading walter-sdk/ui/controller"

require_relative 'controller/base_controller'

# Context
puts "\tLoading walter-sdk/ui/controller"

require_relative 'context'
