require 'pry'

class Node
  attr_reader :letter,
              :children,
              :terminator,
              :selected_suggestions

  def initialize(letter = "", terminator = false)
    @letter = letter
    @terminator = terminator
    @children = []
    @selected_suggestions = []
  end

  def set_terminator
    @terminator = true
  end

  def terminator?
    terminator
  end

  def add_child(letter)
    child_node = Node.new(letter)
    @children << child_node
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

  def index_of_suggestion(selected_suggestion)
    selected_suggestions.find_index do |one_suggestion|
      one_suggestion == selected_suggestion
    end
  end

  def add_selected_suggestion(selected_suggestion)
    index_of_suggestion = index_of_suggestion(selected_suggestion)
    @selected_suggestions << [1, selected_suggestion] if index_of_suggestion == nil
    @selected_suggestion[index_of_suggestion][0] += @selected_suggestions[index_of_suggestion][0] if index_of_suggestion != nil

  end

end
