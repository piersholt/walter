# frozen_string_literal: true

module Capabilities
  module CDChanger
    # Chainable state changes
    module Chainable
      include Constants

      def stopped
        state!(control: CONTROL[:stopped])
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

      def next
        state!(control: CONTROL[:next])
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

      def idle
        state!(status: STATUS[:idle])
        self
      end

      def active
        state!(status: STATUS[:active])
        self
      end

      def ok
        state!(magazine: MAGAZINE[:ok])
        self
      end

      def error
        state!(magazine: MAGAZINE[:error])
        self
      end

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

      def track(index)
        state!(track: index)
        self
      end

      def cd(index)
        state!(cd: index)
        self
      end
    end
  end
end
