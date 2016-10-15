require 'minitest/autorun'
require './lib/tree'

require 'pry'

class TreeTest < Minitest::Test

  def test_tree_exists
    assert Tree.new
  end

  def test_a_tree_has_a_root_node_when_created
    test_tree = Tree.new
    assert test_tree.root_node
  end

  def test_a_tree_can_insert_one_word_into_empty_tree
    test_insert = Tree.new
    assert_equal 'pizza', test_insert.insert('pizza')
  end

  def test_a_tree_can_insert_two_words_into_an_empty_tree
    test_insert = Tree.new
    assert_equal 'cat', test_insert.insert('cat')
    assert_equal 'cats', test_insert.insert('cats')
  end

  def test_tree_count_will_return_zero_when_empty
    test_empty_tree = Tree.new
    # binding.pry
    assert_equal 0, test_empty_tree.count
  end

  def test_tree_count_will_return_one_when_populated_with_one_leaf
    test_one_tree = Tree.new
    test_one_tree.insert('a')
    assert_equal 1, test_one_tree.count
  end

  def test_tree_count_will_return_one_when_populated_with_one_word
    test_one_tree = Tree.new
    test_one_tree.insert('cat')
    assert_equal 1, test_one_tree.count
  end

  def test_tree_count_will_return_two_when_populated_with_two_words
    test_two_tree = Tree.new
    test_two_tree.insert('cat')
    test_two_tree.insert('cats')
    binding.pry
    assert_equal 2, test_two_tree.count
  end



end
