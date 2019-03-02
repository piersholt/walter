# frozen_string_literal: true

puts 'Loading walter-sdk'

puts 'Loading walter-sdk/ui'
ui_root = 'ui'

puts 'Loading walter-sdk/ui/view'
view_root = ui_root + '/view'

require "#{view_root}/header/base_field"
require "#{view_root}/header/base_header"
require "#{view_root}/header/default_header"
require "#{view_root}/header/notification_header"

require "#{view_root}/menu/base_menu_item"
require "#{view_root}/menu/base_menu"
require "#{view_root}/menu/basic_menu"
require "#{view_root}/menu/titled_menu"
require "#{view_root}/menu/static_menu"

puts 'Loading walter-sdk/ui/controller'
controller_root = ui_root + '/controller'

require "#{controller_root}/base_controller"
