# frozen_string_literal: true

# Manager

require_relative 'manager/constants'
require_relative 'manager/logging'

require_relative 'manager/models/device'
require_relative 'manager/models/devices'

require_relative 'manager/notifications/device_handler'

require_relative 'manager/states/defaults'
require_relative 'manager/states/disabled'
require_relative 'manager/states/enabled'
require_relative 'manager/states/on'

require_relative 'manager/state'
require_relative 'manager/properties'
require_relative 'manager/notifications'
require_relative 'manager/actions'
require_relative 'manager/requests'
require_relative 'manager/replies'
require_relative 'manager/controls'
require_relative 'manager/context'
require_relative 'manager/service'

require_relative 'manager/ui'
