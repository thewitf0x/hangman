class Dictionary
    attr_reader :word, :length

  def initialize
    @word = generate_random_word()
    @length = @word.length
  end

  def generate_random_word
    hangman_words = []

    dictionary = File.readlines("5desk.txt")

    dictionary.each do |word|
      word = word.strip
      hangman_words << word if word.length > 5 && word.length < 12 && includes_vowel?(word)
    end

    random_index = rand(0...hangman_words.length)
    random_word = hangman_words[random_index]
    random_word.downcase
  end

  def includes_vowel?(word)
    vowels = "aeiouAEIOU"
    word.each_char { |char| return true if vowels.include?(char) }
    false
  end
end
