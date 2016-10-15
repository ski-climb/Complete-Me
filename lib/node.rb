class Node
  attr_reader :value,
              :children
  attr_accessor :terminator

  def initialize(value = "", terminator = false)
    @value = value
    @terminator = terminator
    @children = []
  end

  def terminator?
    terminator
  end


  def has_children?
  end

  def add_child(node)
    @children << node
  end


end
