# frozen_string_literal: true

module Capabilities
  module Radio
    # CD Changer Reqests
    module CDChangerControl
      include API::Radio

      def next!
        cd_changer_request(arguments: { control: 0x04, mode: 0x00 })
      end

      def play!
        cd_changer_request(arguments: { control: 0x03, mode: 0x00 })
      end

      def stop!
        cd_changer_request(arguments: { control: 0x01, mode: 0x00 })
      end
    end
  end
end
