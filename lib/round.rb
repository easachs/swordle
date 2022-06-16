class Round

  def initialize
    @word = Word.new.sample
    @guess = nil
    @correct = false
    @round_count = 1
    @alphabet = ('A'..'Z').to_a
    @present = []
    @absent = []
  end

  def start
    puts "Welcome to SWORDLE."
    welcome
  end

  def welcome
    puts "Enter p to play or q to quit."
    welcome_input = gets.chomp.downcase
    if welcome_input[0] == "q"
      puts "Ciao!"
    elsif welcome_input[0] == "p"
      game
    else
      puts "Invalid input."
      welcome
    end
  end

  def game
    reset
    puts "A random six letter word has been selected."
    round_start until @correct || @round_count > 6
    puts "You're pathetic! The correct word was #{@word}." if !@correct
    welcome
  end

  def round_start
    puts "Round #{@round_count}\nAlphabet: #{@alphabet.sort.uniq.join}"
    puts "Present: #{@present.sort.uniq.join} / Absent: #{@absent.uniq.join.downcase}\nEnter your guess."
    @round_count += 1
    enter_guess
  end

  def enter_guess
    @guess = gets.upcase.chars.delete_if do |ch|
      !('A'..'Z').to_a.include?(ch)
    end.join[0..5]
    if @guess == @word
      @correct = true
      display
      puts "You win!"
    elsif @guess.length < 6
      puts "Guess must be six letters."
      enter_guess
    elsif !Word.new.words.include?(@guess.downcase)
      puts "Invalid word. Guess again."
      enter_guess
    else
      display
    end
  end

  def display
    puts guess_display
    puts word_display
  end

  def guess_display
    guess_render = "\n "
    @guess.chars.each { |ch| guess_render.concat("#{ch} ") }
    guess_render
  end

  def word_display
    count = 0
    word_render = " "
    @guess.chars.each do |ch|
      if @word.chars[count] == ch
        word_render.concat("#{ch} ")
        @present << ch
      elsif @word.include?(ch)
        word_render.concat("! ")
        @present << ch
      else
        word_render.concat(". ")
        @absent << ch
      end
      @alphabet.delete(ch)
      count += 1
    end
    word_render.concat("\n ")
  end

  def reset
    @word = Word.new.sample
    @guess = nil
    @correct = false
    @round_count = 1
    @alphabet = ('A'..'Z').to_a
    @present = []
    @absent = []
  end
end
