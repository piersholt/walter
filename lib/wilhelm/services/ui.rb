# frozen_string_literal: true

root = 'ui'

# UI
ui_root = root

puts "\tLoading wilhelm/services/ui/view"

require_relative 'ui/view'

puts "\tLoading wilhelm/services/ui/controller"

require_relative 'ui/controller'
