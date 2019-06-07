# frozen_string_literal: trie

# Exception for when chain doesn't handle
class IfYouWantSomethingDone < StandardError
  def message
    'No handler took responsibility!'
  end
end

# Handler implemention validation error
class NaughtyHandler < StandardError
  def initialize(culprit)
    @culprit = culprit
  end

  def message
    "#{@culprit} did not override a required method!!"
  end
end

# Exception for when chain doesn't handle
class FuckingAnarchy < StandardError
  def message
    'NO HEAD OF STATE!'
  end
end
