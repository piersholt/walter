
class Model::BaseList
  def initialize(items_hash, opts = {})
  end

  def sort; end

  def page(i)
  end

  def pointer
  end
end

class CharacterSet < Model::BaseList
  def initialize
    items = Array.new(256) { |i| i => { byte: i, desc: '' } }
    super(items)
  end
end



class View::List < TitledMenu
  PAGE_SIZE_MAX = 8
  ITEMS_PER_CELL = 1
end

:forward
:back
