require './lib/node'
require 'pry'

class Tree
  attr_reader :root_node,
              :word_count,
              :suggestions,
              :weighted_suggestions

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
    separated_words = parse(all_words)
    insert_words(separated_words)
  end

  def parse(all_words)
    words = all_words.split("\n")
    return words
  end

  def insert_words(words)
    words.each do |word|
      insert(word)
    end
  end

  def suggest(chunk)
    @suggestions = []
    @weighted_suggestions = []
    letters = chunk.chars

    return [] unless root_node.has_child?(letters.first)

    chunk_node = find_chunk_node(letters)

    used_words = chunk_node.sorted_selections
    words_on_branch(chunk_node, chunk)

    return @weighted_suggestions = used_words | suggestions
  end

  def words_on_branch(chunk_node, chunk)
    if chunk_node.has_children?
      chunk_node.children.each do |child_node|
        find_words_on_branch(child_node, chunk)
      end
    end

    return suggestions.sort
  end

  def find_words_on_branch(node, word_suggestion)
    word_suggestion += node.letter
    suggestions << word_suggestion if node.terminator?

    if node.has_children?
      node.children.each do |child_node|
        find_words_on_branch(child_node, word_suggestion)
      end
    end
  end

  def find_chunk_node(node = root_node, letters)
    if letters.empty? || ! node.has_children?
      return node
    else
      letter = letters.shift
    end

    child = node.find_child(letter)
    find_chunk_node(child, letters)
  end

  def select(chunk, word)
    letters = chunk.chars
    return unless root_node.has_child?(letters.first)
    chunk_node = find_chunk_node(letters)
    chunk_node.add_selected(word)
  end

end