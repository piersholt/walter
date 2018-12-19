# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class SimulatedCDC < EmulatedDevice
    module Constants
      SCAN_THRESHOLD_SECONDS = 3

      # 0x38
      REQUEST = {
        status: 0x00,
        stop: 0x01,
        play: 0x03,
        seek: 0x04,
        skip: 0x05,
        change_disc: 0x06
      }.freeze

      # 0x39
      CONTROL = {
        off: 0x00,
        start: 0x02,
        next: 0x03,
        previous: 0x04,
        fwd: 0x05,
        rwd: 0x06,
        stop: 0x07,
        changed: 0x08
      }.freeze

      STATUS = {
        no: 0x02,
        yes: 0x09
      }.freeze

      DEFAULT_LOADER = 0b0011_1111

      DEFAULT_STATE = {
        control: CONTROL[:off],
        status: STATUS[:no],
        loader: DEFAULT_LOADER,
        cd: 1,
        track: 1,
        b2: 0,
        b4: 0
      }.freeze
    end
  end
end
