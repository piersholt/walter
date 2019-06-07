# frozen_string_literal: true

# Comment
module NotificationDelegator
  attr_reader :primary_delegate

  def delegate(object)
    raise(FuckingAnarchy, 'no head of state!') unless primary_delegate
    primary_delegate.handle(object)
  end

  HANDLERS = [:handle].freeze

  # add head of estabished chain (instances with successors set)
  def declare_primary_delegate(the_queen)
    raise(NaughtyHandler, 'not nepotistic?') unless HANDLERS.any? do |handler|
      the_queen.respond_to?(handler)
    end
    @primary_delegate = the_queen
  end

  # allows clients to give a list of klasses without setting up the liniage
  # def succession(lineage); end
end
