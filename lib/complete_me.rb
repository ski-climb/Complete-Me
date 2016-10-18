require './lib/tree'

class CompleteMe
  attr_accessor :tree

  def initialize
    @tree = Tree.new
  end

  def insert(word)
    self.tree.insert(word)
  end

  def count
    tree.count
  end

  def suggest(chunk)
    tree.suggest(chunk)
  end

  def populate(words)
    tree.import(words)
  end

  def select(chunk, word)
    tree.select(chunk, word)
  end

end
