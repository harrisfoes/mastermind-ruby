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

