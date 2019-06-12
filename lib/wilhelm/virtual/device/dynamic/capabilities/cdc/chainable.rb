# frozen_string_literal: true

module Capabilities
  module CDChanger
    # Chainable state changes
    module Chainable
      include Constants

      # CONTROL ---------------------------------------------------------------

      def stopped
        state!(control: CONTROL[:stopped])
        self
      end

      def playing_new
        state!(control: CONTROL[:playing_new])
        self
      end

      def playing
        state!(control: CONTROL[:playing])
        self
      end

      def fwd
        state!(control: CONTROL[:fwd])
        self
      end

      def rwd
        state!(control: CONTROL[:rwd])
        self
      end

      def next
        state!(control: CONTROL[:next])
        self
      end

      def previous
        state!(control: CONTROL[:previous])
        self
      end

      def pending
        state!(control: CONTROL[:pending])
        self
      end

      def ready
        state!(control: CONTROL[:ready])
        self
      end

      def check
        state!(control: CONTROL[:check])
        self
      end

      def eject
        state!(control: CONTROL[:eject])
        self
      end

      alias control_next next
      alias control_previous previous

      # STATUS ----------------------------------------------------------------

      def idle
        state!(status: STATUS[:idle])
        self
      end

      def active
        state!(status: STATUS[:active])
        self
      end

      # MAGAZINE --------------------------------------------------------------

      def ok
        state!(magazine: MAGAZINE[:ok])
        self
      end

      def error
        state!(magazine: MAGAZINE[:error])
        self
      end

      # LOADER --------------------------------------------------------------

      def zero
        state!(loader: LOADER[:zero])
        self
      end

      def one
        state!(loader: LOADER[:one])
        self
      end

      def two
        state!(loader: LOADER[:two])
        self
      end

      def three
        state!(loader: LOADER[:three])
        self
      end

      def four
        state!(loader: LOADER[:four])
        self
      end

      def five
        state!(loader: LOADER[:five])
        self
      end

      def six
        state!(loader: LOADER[:six])
        self
      end

      # TRACK --------------------------------------------------------------

      def track(index)
        state!(track: index)
        self
      end

      def track_next
        track(current_track + 1)
      end

      def track_previous
        track(current_track - 1)
      end

      # CD --------------------------------------------------------------

      def cd(index)
        state!(cd: index)
        self
      end
    end
  end
end
