require 'pry'

class Tree
  attr_reader :root_node,
              :word_count

  def initialize
    @root_node = Node.new
  end

  def insert(word)
    letters = word.chars
    insert_as_letters(letters)
    word
  end

  def insert_as_letters(node = root_node, letters)
    letter = letters.shift
    if letter
      if node.has_child?(letter)
        insert_as_letters(node.find_child(letter), letters)
      else
        child_node = node.add_child(letter)
        child_node.set_terminator if letters.empty?
        insert_as_letters(child_node, letters)
      end
    end
  end




  def count(node = root_node)
    @word_count = 0
    count_children(node)
    word_count
  end

  def count_children(node)
    @word_count += 1 if node.terminator?
    node.children.each do |child|
      count(child)
    end
  end


end
