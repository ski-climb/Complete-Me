require 'pry'

class Node
  attr_reader :letter,
              :children,
              :terminator

  def initialize(letter = "", terminator = false)
    @letter = letter
    @terminator = terminator
    @children = []
  end

  def set_terminator
    @terminator = true
  end

  def terminator?
    terminator
  end

  def add_child(letter)
    @children << Node.new(letter)
  end

  def has_child?(letter)
    !! find_child(letter)
  end

  def find_child(letter)
    children.find do |one_node|
      one_node.letter == letter
    end
  end

  def has_children?
    ! children.empty?
  end

  def is_leaf?
    (! has_children?) and terminator?
  end

end