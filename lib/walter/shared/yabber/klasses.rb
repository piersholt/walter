# frozen_string_literal: true

module Messaging
  # Message constants
  module Klasses
    include Constants

    TYPE_CLASS_MAP = {
      ACTION => Action,
      NOTIFICATION => Notification,
      REQUEST => Request,
      REPLY => Reply
    }.freeze
  end
end
