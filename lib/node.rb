class Node
  attr_reader :letter,
              :children,
              :terminator,
              :selected_words

  def initialize(letter = "", terminator = false)
    @letter = letter
    @terminator = terminator
    @children = []
    @selected_words = {}
  end

  def set_terminator
    @terminator = true
  end

  def terminator?
    terminator
  end

  def add_child(letter)
    child_node = Node.new(letter)
    children << child_node
    return child_node
  end

  def has_child?(letter)
    !! find_child(letter)
  end

  def find_child(letter)
    children.find do |node|
      node.letter == letter
    end
  end

  def has_children?
    ! children.empty?
  end

  def is_leaf?
    (! has_children?) and terminator?
  end

  def add_selected(word)
    add_new(word) unless present?(word)
    increment(word)
  end

  def present?(word)
    @selected_words.has_key?(word)
  end

  def add_new(word)
    @selected_words[word] = 0
  end

  def increment(word)
    @selected_words[word] += 1
  end

  def sorted_selections
    sorted = selected_words.sort_by{ |k, v| v }.reverse.to_h.keys
    return sorted
  end

end
