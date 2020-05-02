require "./dict.rb"
require "./player.rb"
require "./save_load.rb"
require "yaml"

class Hangman
  include Save_load

  attr_accessor :hidden_word, :player, :secret_word, :length, :previous_guesses, :game_over, :turn

  def initialize
    @secret_word = Dictionary.new
    @length = @secret_word.length
    @player = Player.new
    # @stickman =
    @hidden_word = Array.new(@length, "_")
    @game_over = false
    @previous_guesses = []
    @turn = 1
  end

  def take_turn
    show_partial() if first_go?() #only shows the board again if it's the players first turn
    letter = get_guess()
    compare_guess_with_secret(letter)
    update_previous_guesses(letter) #if you guess a wrong letter, it's added to previous guesses
    update_remaining_guesses(letter) #if hidden word doesn't include letter, you lose a guess
    show_partial()
    win_lose_or_show_guesses()
    @turn += 1
  end

  def first_go?
    return true if @turn == 1
    false
  end

  def win_lose_or_show_guesses
    if win?()
      @game_over = true
      you_win()
    elsif lose?()
      @game_over = true
      you_lose()
    else
      show_remaining_guesses()
    end
  end

  def get_guess
    puts "\nEnter a letter:\n"
    letter = gets.chomp
    letter = letter.downcase
    guess_check(letter)
  end

  def guess_check(letter)
    if valid_letter?(letter) && !@previous_guesses.include?(letter)
      return letter
    elsif previous_guesses.include?(letter)
      puts "\nYou already guessed that letter! Try a different one.\n"
    else
      puts "\nThat's not going to work!\n"
    end
    get_guess()
  end

  def valid_letter?(letter)
    alpha = ("a".."z").to_a + ("A".."Z").to_a
    return false if !letter.is_a?(String) || letter.length != 1 || !alpha.include?(letter)
    true
  end

  def show_remaining_guesses()
    puts "You have #{@player.guesses} guesses remaining."
    puts
  end

  def update_remaining_guesses(letter)
    if !@hidden_word.include?(letter)
      @player.guesses -= 1
    end
  end

  def update_previous_guesses(letter)
    if !@hidden_word.include?(letter)
      @previous_guesses << letter
    end
  end

  def compare_guess_with_secret(letter)
    secret = @secret_word.word
    secret.each_char.with_index do |char, idx|
      if letter == char
        @hidden_word[idx] = letter
      end
    end
  end

  def show_partial()
    puts "\nSECRET WORD: \t#{@hidden_word.join(" ")}"
    if @previous_guesses.length > 0
      puts "\nWRONG LETTERS: #{@previous_guesses.join(",")}\n\n"
    else
      puts "\nWRONG LETTERS: none\n\n"
    end
  end

  def win?
    return true if @hidden_word.join("") == @secret_word.word
    false
  end

  def lose?
    return true if @player.guesses == 0
    false
  end

  def you_win
    puts "Nice guesswork, #{@player.name}. You win!\n"
  end

  def you_lose
    puts "Bad luck, #{@player.name}. You lose! The word was #{@secret_word.word}\n"
  end

  def ask_to_save
    puts "Do you want to save? y/n"
    answer = gets.chomp.downcase
    if answer == "y"
      self.save
      puts "\nGame saved!\n"
      sleep 1
    else
      return
    end
  end

  def ask_to_load
    puts "Do you want to load a previous game? y/n"
    answer = gets.chomp.downcase
    if answer == "y"
      self.load
      puts "\nGame loaded! You can keep playing.\n"
      sleep 1
      show_partial()
    else
      return
    end
  end
end
