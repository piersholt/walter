# frozen_string_literal: false

# All mehods that are expected to be overriden by Delegates
module DelegateValidation
  def handle(*)
    raise(NaughtyHandler, self.class.name)
  end

  def forward(*)
    raise(NaughtyHandler, self.class.name)
  end

  def responsibility
    raise(NaughtyHandler, self.class.name)
  end
end
