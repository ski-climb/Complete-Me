require './lib/node'
require 'pry'

class Tree
  attr_reader :root_node,
              :word_count,
              :suggestions

  def initialize
    @root_node = Node.new
  end

  def insert(word)
    letters = word.chars
    add_to_tree(letters)
    word
  end

  def add_to_tree(node = root_node, letters)
    return if letters.empty?

    letter = letters.shift
    go_to_node(node, letters, letter) if node.has_child?(letter)
    make_child(node, letters, letter) unless node.has_child?(letter)
  end

  def go_to_node(node, letters, letter)
    node.find_child(letter).set_terminator if letters.empty?
    add_to_tree(node.find_child(letter), letters)
  end

  def make_child(node, letters, letter)
    child_node = node.add_child(letter)
    child_node.set_terminator if letters.empty?
    add_to_tree(child_node, letters)
  end

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

  def import(all_words)
    separated_words = parse_string(all_words)
    insert_words(separated_words)
  end

  def parse_string(all_words)
    words = all_words.split("\n")
    return words
  end

  def insert_words(words)
    # binding.pry
    words.each do |word|
      insert(word)
    end
  end

  def suggest(stem)
    @suggestions = []
    letters = stem.chars

    return [] unless root_node.has_child?(letters.first)

    stem_node = find_node(letters)
    beginning_of_word = stem

    if stem_node.has_children?
      stem_node.children.each do |node|
        find_words(node, beginning_of_word)
      end
    end

    return suggestions
  end

  def find_words(node, beginning_of_word)
    beginning_of_word += node.letter
    @suggestions << beginning_of_word if node.terminator?
    if node.has_children?
      node.children.each do |child_node|
        find_words(child_node, beginning_of_word)
      end
    end
  end

  def find_node(node = root_node, letters)
    return node if letters.empty?
    letter = letters.shift

    child = node.find_child(letter)
    find_node(child, letters)
  end

end
