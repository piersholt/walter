# frozen_string_literal: false

module Wilhelm::Virtual::Capabilities
  module ButtonHelpers
    def wait(wait_time = 0.01)
      Kernel.sleep(wait_time)
    end

    def press_and_release(method:, to:, press:, release:, interval: 0.05)
      public_send(method, to: to, action: press)
      wait(interval)
      public_send(method, to: to, action: release)
      # mfl_func_button(to: to, action: press)
      # mfl_func_button(to: to, action: release)
    end
  end
end
