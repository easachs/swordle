class Round

  def initialize
    @word = Word.new.sample.upcase
    @guess = nil
    @correct = false
  end

  def start
    puts "Welcome to Swordle.\nEnter p to play or q to quit."
    welcome
  end

  def welcome
    welcome_input = gets.chomp.downcase
    if welcome_input[0] == "q"
      puts "Goodbye."
    elsif welcome_input[0] == "p"
      puts "A random six-letter word has been selected."
      game
    else
      puts "Invalid input."
      welcome
    end
  end

  def game
    round_count = 0
    until @correct || round_count >= 6 do
      round
      round_count += 1
    end
    if !@correct
      puts "You lose, the correct word was #{@word}."
    end
  end

  def round
    puts "Enter your guess."
    @guess = gets.chomp.strip.upcase
    if @guess == @word
      @correct = true
      puts "You win!"
    elsif @guess.length != 6
      puts "Guess must be six letters."
      round
    else
      count = 0
      6.times do
        if @word.chars[count] == @guess.chars[count]
          puts "[#{@guess[count]}] [#{@word[count]}] Letter ##{count + 1} is CORRECT."
        elsif @word.include?(@guess.chars[count])
          puts "[#{@guess.chars[count]}] [!] Letter ##{count + 1} is MISPLACED."
        else
          puts "[#{@guess.chars[count]}] [ ] Letter ##{count + 1} is ABSENT."
        end
        count += 1
      end
    end
  end
end
