class Importer

  def import(file)
    @words = file.split("\n")
    insert(words)
  end

  def word_cleaner(word)
    clean_word = word.strip
    return clean_word
  end

  def imported_word_count
    0
  end

  def words_count
    return words.count
  end

  def import_one_word(count)
    return words[count]
  end

end