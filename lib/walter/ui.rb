# frozen_string_literal: true

root = 'ui'

# UI
ui_root = root

puts "\tLoading walter/ui/view"

require "#{ui_root}/view/header/audio"

require "#{ui_root}/view/bluetooth/device"
require "#{ui_root}/view/bluetooth/index"

require "#{ui_root}/view/audio/now_playing"
require "#{ui_root}/view/audio/index"

puts "\tLoading walter/ui/controller"

require "#{ui_root}/controller/bluetooth_controller"
require "#{ui_root}/controller/audio_controller"
