require './hangman.rb'

game = Hangman.new

until game.game_over
    game.take_turn
end