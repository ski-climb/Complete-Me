require './lib/node'
require 'pry'

class Tree
  attr_reader :root_node,
              :word_count

  def initialize
    @root_node = Node.new
  end

  def insert(word)
    letters = word.chars
    add_to_tree(letters)
    binding.pry
    word
  end

  def add_to_tree(node = root_node, letters)
    return if letters.empty?

    letter = letters.shift
    binding.pry
    go_to_child(node, letters, letter) if node.has_child?(letter)
    make_child(node, letters, letter) unless node.has_child?(letter)
  end

  def go_to_child(node, letters, letter)
    # binding.pry
    node.set_terminator if letters.empty?
    # binding.pry
    add_to_tree(node.find_child(letter), letters)
  end

  def make_child(node, letters, letter)
    child_node = node.add_child(letter)
    # binding.pry
    child_node.set_terminator if letters.empty?
    # binding.pry
    add_to_tree(child_node, letters)
  end

# def add_to_tree(node = root_node, letters)
#    return if letters.empty?
#    letter = letters.shift

#    if node.has_child?(letter)
#      node.set_terminator if letters.empty?
#      add_to_tree(node.find_child(letter), letters)
   
#    unless node.has_child?(letter)
#      child_node = node.add_child(letter)
#      child_node.set_terminator if letters.empty?
#      add_to_tree(child_node, letters)
#    end
#  end


  def count(node = root_node)
    @word_count = 0
    count_children(node)
    word_count
  end

  def count_children(node)
    @word_count += 1 if node.terminator?
    node.children.each do |child|
      count_children(child)
    end
  end


end
