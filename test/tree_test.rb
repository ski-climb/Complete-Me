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

  def test_tree_count_will_return_zero_when_empty
    test_empty_tree = Tree.new
    assert_equal 0, test_empty_tree.count
  end

  def test_tree_count_will_return_one_when_populated_with_one_leaf
    test_one_tree = Tree.new
    test_one_tree.insert('a')
    assert_equal 1, test_one_tree.count
  end

  def test_a_tree_can_insert_one_word_into_empty_tree
    test_insert = Tree.new
    assert_equal 'pizza', test_insert.insert('pizza')
  end

  def test_tree_count_will_return_one_when_populated_with_one_word
    test_one_tree = Tree.new
    test_one_tree.insert('cat')
    assert_equal 1, test_one_tree.count
  end

  def test_a_tree_can_insert_two_words_into_an_empty_tree
    test_insert = Tree.new
    assert_equal 'cat', test_insert.insert('cat')
    assert_equal 'cats', test_insert.insert('cats')
    assert_equal 2, test_insert.count
  end

  def test_tree_count_will_return_two_when_populated_with_two_words_on_the_same_branch_short_first
    test_two_tree = Tree.new
    test_two_tree.insert('cat')
    test_two_tree.insert('cats')
    assert_equal 2, test_two_tree.count
  end

  def test_tree_count_will_return_two_when_populated_with_two_words_on_the_same_branch_long_first
    test_two_tree = Tree.new
    test_two_tree.insert('cats')
    test_two_tree.insert('cat')
    assert_equal 2, test_two_tree.count
  end

  def test_a_tree_will_not_insert_the_same_word_twice_into_an_empty_tree
    test_insert = Tree.new
    assert_equal 'cat', test_insert.insert('cat')
    assert_equal 'cat', test_insert.insert('cat')
    assert_equal 1, test_insert.count
  end

  def test_a_tree_can_create_new_branch_from_existing_branch
    test_mid_branch = Tree.new
    assert_equal 'cat', test_mid_branch.insert('cat')
    assert_equal 'cats', test_mid_branch.insert('cats')
    assert_equal 'cattle', test_mid_branch.insert('cattle')
    assert_equal 3, test_mid_branch.count
  end

  def test_a_tree_can_create_multiple_branches
    test_mid_branch = Tree.new
    assert_equal 'cat', test_mid_branch.insert('cat')
    assert_equal 'cats', test_mid_branch.insert('cats')
    assert_equal 'cog', test_mid_branch.insert('cog')
    assert_equal 'cogs', test_mid_branch.insert('cogs')
    assert_equal 'cattle', test_mid_branch.insert('cattle')
    assert_equal 5, test_mid_branch.count
  end

  def test_a_tree_inserts_zero_words_when_given_empty_file
    test_empty = Tree.new
    # binding.pry
    file_no_words = File.read('./test/empty_file.txt')
    test_empty.import(file_no_words)
    assert_equal 0, test_empty.count
  end

  def test_a_tree_inserts_one_word_when_file_has_one_word
    test_one = Tree.new
    file_one_word = File.read('./test/test_input_file1.txt')
    test_one.import(file_one_word)
    assert_equal 1, test_one.count
  end

  def test_a_tree_inserts_several_words_from_test_file
    test_seven = Tree.new
    seven_words = File.read('./test/test_input_file6.txt')
    test_seven.import(seven_words)
    assert_equal 7, test_seven.count
  end

  def test_a_tree_inserts_representative_sample_from_dictionary_file
    test_insert_representative = Tree.new
    small_sample = File.read('./test/small_dictionary.txt')
    test_insert_representative.import(small_sample)
    assert_equal 236, test_insert_representative.count
  end





end
