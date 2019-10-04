# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module Mock
            # Quick Telephone Number
            module Quick
              include Constants

              MOD_PROG = 'Quick'

              def quick_disable
                quick_exit
                @quick_index = 0
              end

              def quick_enable
                on! if off?
                quick_open
              end

              def quick_open
                @quick_index = 0
                quick_name(quick_index)
                sleep(1)
                quick_number(quick_index)
              end

              def quick_forward
                @quick_index = quick_index + 1
                quick_name(quick_index)
                sleep(1)
                quick_number(quick_index)
              end

              def quick_back
                @quick_index = quick_index - 1
                quick_name(quick_index)
                sleep(1)
                quick_number(quick_index)
              end

              private

              def quick_index
                @quick_index ||= 1
              end
            end
          end
        end
      end
    end
  end
end
