# frozen_string_literal: false

module Wilhelm
  module Virtual
    module Constants
      module Events
        # Virtual::Device::Telephone Events
        module Telephone
          # Action related events
          module Action
            DIRECTORY_OPEN     = :directory_open
            DIRECTORY_BACK     = :directory_back
            DIRECTORY_FORWARD  = :directory_forward
            DIRECTORY_SELECT   = :directory_select

            TOP_8_OPEN   = :top_8_open
            TOP_8_SELECT = :top_8_select

            LAST_NUMBERS_BACK    = :last_numbers_back
            LAST_NUMBERS_FORWARD = :last_numbers_forward

            SMS_OPEN     = :sms_open
            SMS_SELECT   = :sms_select
          end

          # Control related events
          module Control
            TELEPHONE_BUTTON = :control
          end

          include Action
          include Control
        end
      end
    end
  end
end
