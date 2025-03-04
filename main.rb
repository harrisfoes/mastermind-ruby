
CODE_ELEMENTS = ['r','g','b','y','m','c'].freeze
CODE_LENGTH = 4
TRIES_LIMIT = 10 
CORRECT_GUESS = 'XXXX'.freeze


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
  result

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
  eval == 'XXXX' ? true : false 
end

# game section
secret_code =  generate_code()
tries = 1 
eval = ''

until tries == TRIES_LIMIT or guess_correct?(eval) do
  p "Your guess: "
  guess = gets.chomp
  
  eval = evaluate_guess(guess, secret_code)

  p "Guess number #{tries}, guess: #{guess} result: #{eval}"

  tries += 1
end

if guess_correct?(eval)
  p "You cracked the code!"
elsif
  p "You didn't crack the code! "
end

p "The answer is #{secret_code.join("")}"

#TODO, store guesses tries and results in a hash
#refactor to enable computer player

# if computer player
#   user will provide secret code
#   computer will supply guesses
#
# if user player
#   computer will generate secret code
#   player will supply guesses
#
#   keep it simple!
