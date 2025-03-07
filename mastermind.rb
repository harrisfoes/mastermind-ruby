class Mastermind

  CODE_ELEMENTS = ['r','g','b','y','m','c'].freeze
  CODE_LENGTH = 4
  TRIES_LIMIT = 10 
  CORRECT_GUESS = 'XXXX'.freeze

  def initialize()
    @secret_code = []
    @tries = 0
    @guess = []

  end

  def generate_code()
    randy = []
    CODE_LENGTH.times { randy << CODE_ELEMENTS[rand(CODE_ELEMENTS.length)]}
    randy
  end

  def evaluate_guess(guess, answer)

    result = []
    guess_used = Array.new(guess.length, false) 
    answer_used = Array.new(answer.length, false)

    guess.chars.each_with_index do | ch, idx |
      if ch == answer[idx]
        result << 'X'
        guess_used[idx] = true 
        answer_used[idx] = true
      end
    end

    guess.chars.each_with_index do | guess, idx|
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

  def guess_correct?(eval)
    eval == CORRECT_GUESS ? true : false
  end

  def display()
    #TODO display the guesses, tries and eval so far
  end

  def add_guess()
    #TODO add a guess, maybe it can be added to guess then => eval 
  end

end
