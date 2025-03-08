class Mastermind
  attr_accessor :secret_code, :tries

  CODE_ELEMENTS = ['r','g','b','y','m','c'].freeze
  CODE_LENGTH = 4
  TRIES_LIMIT = 10 
  CORRECT_GUESS = 'XXXX'.freeze

  def initialize()
    @secret_code = []
    @tries = 1

    ## Hash with {tries:1 , guess: rrby eval: => XXx}
    @game_records = []

  end

  def generate_code()
    randy = []
    CODE_LENGTH.times { randy << CODE_ELEMENTS[rand(CODE_ELEMENTS.length)]}
    randy
  end

  def prompt()
    puts "You are now the CODEBREAKER"
    puts "The valid colors are r,g,b,y,m,c"
    puts "The code is a 4-COLOR combination of the above"
  end

  def evaluate_guess(guess, answer)
    #answer and guess should be arrays

    result = []
    guess_used = Array.new(guess.length, false) 
    answer_used = Array.new(answer.length, false)

    guess.each_with_index do | ch, idx |
      if ch == answer[idx]
        result << 'X'
        guess_used[idx] = true 
        answer_used[idx] = true
      end
    end

    guess.each_with_index do | guess, idx|
      next if guess_used[idx]
      
      answer.each_with_index do | ans, jdx|
        if !answer_used[jdx] && guess == ans
          result << 'x'
          answer_used[jdx] = true
          break
        end
      end 
    end
    result.join("")
  end

  def guess_correct?()
    if @game_records.length > 0
      @game_records.last[:eval] == CORRECT_GUESS ? true : false
    end
  end

  def display()
    @game_records.each do | record | 
      p "Try number: # #{record[:try]} is #{record[:guess]}, eval: #{record[:eval]}"
    end
  end

  def add_game_record(try, guess, eval)
    @game_records << { try: try, guess:  guess, eval: eval }
  end

end


class User_Plays_MM < Mastermind

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


#game2 = User_Plays_MM.new🤣
#game2.start()

class PC_Plays_MM < Mastermind
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
    until tries == Mastermind::TRIES_LIMIT + 1 or guess_correct? do
      computer_guess = generate_code()
      eval = evaluate_guess(computer_guess, secret_code)
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

game3 = PC_Plays_MM.new
game3.start()
