#saving and loading methods
require 'yaml'

module Save_load
  def save
    File.open("save.yaml", "w+"){|f| f.write(YAML::dump(self))}
  end

  def load
    File.open("save.yaml") do |f|
      x = YAML::load(f)
      self.secret_word = x.secret_word
      self.length = x.length 
      self.player = x.player
      self.hidden_word = x.hidden_word
      self.game_over = x.game_over
      self.previous_guesses = x.previous_guesses
      self.turn = x.turn
      puts "GAME LOADED..."
      sleep 1.5
    end
  end
end
