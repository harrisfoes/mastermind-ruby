class UserPlaysMM < Mastermind

  def initialize()
    super

    @secret_code = generate_code() 
  end

  def prompt()
    super  
    puts "Your guess will be evaluated as follows: "
    puts "X - if color and it's position is correct"
    puts "x - if color is correct and it's position is wrong"
    puts "You have #{Mastermind::TRIES_LIMIT} tries"
  end

  def start()
    prompt()
    get_all_guesses()
    final_result()
  end

  def get_all_guesses()
    until @tries == Mastermind::TRIES_LIMIT + 1 or guess_correct? do

      if @game_records.length > 0
        display()
      end

      guess = get_player_guess()
      eval = evaluate_guess(guess.chars, @secret_code)
      add_game_record(@tries, guess, eval)

      @tries += 1
    end
  end

  def get_player_guess()
    loop do
      print "What is your guess?: "
      guess = gets.chomp()

      return guess if guess.match?(/^[rgbymc]{4}$/)

      puts "Please select a four-letter combination of [r,g,b,y,m,c]"
    end

  end

  def final_result()
    display()
    if guess_correct?
      puts "You cracked the code!"
    elsif
      puts "You didn't crack it!"
    end

    puts "The code is #{@secret_code.join("")}"
  end


end


