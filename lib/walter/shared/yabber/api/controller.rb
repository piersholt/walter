# frozen_string_literal: true

module Messaging
  module API
    # Comment
    module Controller
      include Constants

      # def send_me_everyone
      #   everyone?
      # end
      #
      # def everyone?
      #   evvveeerrrryyyyoooonnnneeee!
      # end
      #
      # def evvveeerrrryyyyoooonnnneeee!
      #   thy_will_be_done!(TARGET, PLAYER)
      # end

      # TARGET

      def player!(callback)
        so?(TARGET, PLAYER, {}, callback)
      end

      def volume_up!
        thy_will_be_done!(TARGET, VOLUME_UP)
      end

      def volume_down!
        thy_will_be_done!(TARGET, VOLUME_DOWN)
      end

      # PLAYER

      def play!
        thy_will_be_done!(PLAYER, PLAY)
      end

      def pause!
        thy_will_be_done!(PLAYER, PAUSE)
      end

      def stop!
        thy_will_be_done!(PLAYER, STOP)
      end

      def next!
        thy_will_be_done!(PLAYER, SEEK_NEXT)
      end

      def previous!
        thy_will_be_done!(PLAYER, SEEK_PREVIOUS)
      end

      def scan_forward_start!
        thy_will_be_done!(PLAYER, SCAN_FORWARD_START)
      end

      def scan_forward_stop!
        thy_will_be_done!(PLAYER, SCAN_FORWARD_STOP)
      end

      def scan_backward_start!
        thy_will_be_done!(PLAYER, SCAN_BACKWARD_START)
      end

      def scan_backward_stop!
        thy_will_be_done!(PLAYER, SCAN_BACKWARD_STOP)
      end
    end
  end
end
