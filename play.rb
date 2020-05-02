require './hangman.rb'

game = Hangman.new

game.ask_to_load

until game.game_over
    game.take_turn
    game.ask_to_save
end