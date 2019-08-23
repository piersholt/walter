# frozen_string_literal: true

require_relative 'state/constants'
require_relative 'state/model'
require_relative 'state/status'
require_relative 'state/led'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::State
          module State
            include Model
            include Status
            include LED

            def dial!
              @layout = :dial
            end

            def dial?
              @layout == :dial
            end

            def pin!
              @layout = :pin
            end

            def pin?
              @layout == :pin
            end

            def directory!
              @layout = :directory
            end

            def directory?
              @layout == :directory
            end

            def top_8!
              @layout = :top_8
            end

            def top_8?
              @layout == :top_8
            end

            def info!
              @layout = :info
            end

            def info?
              @layout == :info
            end

            def sos!
              @layout = :sos
            end

            def sos?
              @layout == :sos
            end

            def smses!
              @layout = :smses
            end

            def smses?
              @layout == :smses
            end
          end
        end
      end
    end
  end
end
