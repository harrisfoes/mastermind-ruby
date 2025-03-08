require_relative 'codebreaker'

class PCPlaysMM < Mastermind

  def initialize()
    super
  end

  def prompt()
    super
    puts "You will supply the code and the computer will try to guess"
    puts "In #{Mastermind::TRIES_LIMIT} tries"
  end

  def start()
    @secret_code = get_player_made_code().chars

    generate_guesses()
    display()
    final_result()
  end

  def get_player_made_code()
    loop do
      print "What is the code?: "
      secret_code = gets.chomp()

      return secret_code if secret_code.match?(/^[rgbymc]{4}$/)

      puts "Please select a four-letter combination of [r,g,b,y,m,c]"
    end
  end

  def generate_guesses()
    codebreaker = Codebreaker.new 
    until tries == Mastermind::TRIES_LIMIT + 1 or guess_correct? do
      computer_guess = codebreaker.make_guess
      # computer_guess = generate_code()
      eval = evaluate_guess(computer_guess, secret_code)
      codebreaker.update_possible_codes(computer_guess, eval)
      add_game_record(@tries, computer_guess.join, eval)

      @tries += 1

    end
  end

  def final_result()
    if guess_correct?
      p "The computer cracked the code!"
    elsif
      p "The computer didn't crack the code! "
    end

    puts "The code is #{@secret_code.join}"
  end

end


