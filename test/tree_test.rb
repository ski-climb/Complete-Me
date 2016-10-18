require 'simplecov'
SimpleCov.start
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

  def test_a_tree_suggests_a_word_when_tree_contains_one_word
    test_one_suggestion = Tree.new
    test_one_suggestion.insert('cat')
    assert_equal ['cat'], test_one_suggestion.suggest('c')
  end

  def test_a_tree_suggests_a_word_when_given_more_than_one_letter
    test_one_suggestion = Tree.new
    test_one_suggestion.insert('cat')
    assert_equal ['cat'], test_one_suggestion.suggest('ca')
  end

  def test_a_tree_suggests_correct_word_when_tree_contains_two_words
    test_two_suggestion = Tree.new
    test_two_suggestion.insert('cat')
    test_two_suggestion.insert('dog')
    assert_equal ['dog'], test_two_suggestion.suggest('d')
  end

  def test_a_tree_suggests_two_words_when_tree_contains_two_words
    test_two_suggestion = Tree.new
    test_two_suggestion.insert('cat')
    test_two_suggestion.insert('cog')
    assert_equal ['cat', 'cog'], test_two_suggestion.suggest('c')
  end

  def test_tree_returns_suggested_word_even_when_word_termination_is_not_a_leaf_node
    test_two_suggestion = Tree.new
    test_two_suggestion.insert('cog')
    test_two_suggestion.insert('cogs')
    assert_equal ['cog', 'cogs'], test_two_suggestion.suggest('c')
  end

  def test_tree_with_one_word_returns_no_words_when_no_words_match_the_original_word_for_suggestion
    test_no_results = Tree.new
    test_no_results.insert('cat')
    assert_equal [], test_no_results.suggest('jibberishlyisms')
  end

  def test_tree_with_seven_words_suggests_no_words_when_user_input_is_completely_different
    test_seven = Tree.new
    seven_words = File.read('./test/test_input_file6.txt')
    test_seven.import(seven_words)
    assert_equal [], test_seven.suggest('tira')
  end

  def test_tree_returns_empty_array_when_original_word_for_suggestion_is_longer_than_existing_words
    test_no_results = Tree.new
    test_no_results.insert('cat')
    assert_equal [], test_no_results.suggest('cats')
  end

  def test_tree_suggests_proper_word_as_longer_original_word_for_suggestion_is_provided
    test_seven = Tree.new
    seven_words = File.read('./test/test_input_file6.txt')
    test_seven.import(seven_words)
    assert_equal ['cage', 'cages', 'cat', 'cats', 'cattle'], test_seven.suggest('ca')
  end

  def test_tree_suggests_proper_word_as_longer_stem_word_for_suggestion_is_provided
    test_seven = Tree.new
    seven_words = File.read('./test/test_input_file6.txt')
    test_seven.import(seven_words)
    assert_equal ['cog', 'cogs'], test_seven.suggest('co')
  end

  def test_tree_can_properly_suggest_when_given_a_larger_data_set
    test_sample = Tree.new
    sample_words = File.read('./test/small_dictionary.txt')
    test_sample.import(sample_words)
    assert_equal ['underbottom', 'undextrous'], test_sample.suggest('und')
  end

  def test_tree_select_word_from_suggested_list_when_tree_is_empty
    test_select = Tree.new
    test_select.select("ca", "cat")
    assert_equal({}, test_select.root_node.selected_words)
  end

  def test_tree_is_not_influenced_by_selecting_words_which_do_not_exist_in_tree
    test_select = Tree.new
    test_select.insert("cat")
    test_select.select("ca", "boogers")
    assert_equal ["cat"], test_select.suggest("ca")
    # does 'boogers' exist in the dictionary?
  end

  def test_selected_word_is_along_same_branch_as_stub
    test_select = Tree.new
    test_select.insert("cat")
    test_select.insert("boogers")
    test_select.select("ca", "boogers")
    assert_equal ["cat"], test_select.suggest("ca")
    # is 'ca' a substring of 'boogers'
  end

  def test_tree_select_word_from_suggested_list
    test_select = Tree.new
    seven_words = File.read('./test/test_input_file6.txt')
    test_select.import(seven_words)
    test_select.select("ca", "cat")
    assert_equal({"cat"=>1}, test_select.find_stub_node(["c", "a"]).selected_words)
  end

  def test_tree_select_same_word_from_suggested_list_twice
    test_select = Tree.new
    seven_words = File.read('./test/test_input_file6.txt')
    test_select.import(seven_words)
    test_select.select("ca", "cat")
    test_select.select("ca", "cat")
    assert_equal({"cat"=>2}, test_select.find_stub_node(["c", "a"]).selected_words)
  end

  def test_tree_returns_weighted_suggestion_list_for_one_word_in_tree
    test_one_word = Tree.new
    test_one_word.insert("cat")
    test_one_word.select("ca", "cat")
    assert_equal ["cat"], test_one_word.suggest('ca')
  end

  def test_tree_returns_weighted_suggestion_list_for_seven_words_in_tree
    test_seven_words = Tree.new
    seven_words = File.read('./test/test_input_file6.txt')
    test_seven_words.import(seven_words)
    test_seven_words.select("ca", "cats")
    assert_equal ["cats", "cage", "cages", "cat", "cattle"], test_seven_words.suggest('ca')
  end

  def test_selecting_a_word_only_influences_word_suggestions_for_that_substring_and_not_related_or_longer_but_similar_substrings
    test_ten_words = Tree.new
    ten_words = File.read('./test/test_input_file7.txt')
    test_ten_words.import(ten_words)
    2.times { test_ten_words.select("ca", "cats") }
    3.times { test_ten_words.select("cat", "cattle") }
    assert_equal ["cats", "cage", "cages", "cat", "caterwaul", "caterwauled", "caterwauling", "cattle"], test_ten_words.suggest('ca')
    assert_equal ["cattle", "cat", "caterwaul", "caterwauled", "caterwauling", "cats"], test_ten_words.suggest('cat')
  end

  def test_tree_returns_weighted_suggestion_list_when_more_than_one_word_has_been_selected
    test_two_selections = Tree.new
    test_two_selections.insert("pizza")
    test_two_selections.insert("pizzeria")
    test_two_selections.insert("pizzicato")
    3.times { test_two_selections.select("piz", "pizzeria") }
    2.times { test_two_selections.select("pi", "pizza") }
    1.times { test_two_selections.select("pi", "pizzicato") }
    assert_equal ["pizzeria", "pizza", "pizzicato"], test_two_selections.suggest('piz')
    assert_equal ["pizza", "pizzicato", "pizzeria"], test_two_selections.suggest('pi')
  end

  def test_tree_suggest_from_tree_when_stub_is_not_in_tree
    test_select = Tree.new
    test_select.insert("cat")
    test_select.insert("cats")
    test_select.insert("cab")
    assert_equal [], test_select.suggest("cap")
  end

end
