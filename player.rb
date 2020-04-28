class Player
  attr_reader :name
  attr_accessor :guesses

  def initialize
    @name = get_name()
    @guesses = 10
  end

  def get_name()
    puts "\nWhat's your name?\n"
    name = gets.chomp
    if valid_name?(name)
      return name.capitalize
    else
      puts "\nHey, that's not a name! Don't be yanking my chain.\n"
      get_name()
    end
  end

  def valid_name?(name)
    return false if !name.is_a?(String) || name.length < 3

    alpha = ("a".."z").to_a + ("A".."Z").to_a
    name.each_char { |char| return false if !alpha.include?(char) }
    true
  end
end
