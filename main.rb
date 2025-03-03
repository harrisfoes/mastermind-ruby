puts "This is a Mastermind Game"
puts "Can you break the code?"

CODE_ELEMENTS = ['r','g','b','y'].freeze
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
  result
end

def guess_correct?(eval)
  eval == 'XXXX' ? true : false 
end

puts "This is the secret code"
secret_code =  generate_code()
#p secret_code

tries = 1 
eval = ''

until tries == TRIES_LIMIT or guess_correct?(eval) do
  p "Your guess: "
  guess = gets.chomp
  
  eval = evaluate_guess(guess, secret_code).join("")

  p "Guess number #{tries}, guess: #{guess} result: #{eval}"

  tries += 1
end

if guess_correct?(eval)
  p "You cracked the code!"
elsif
  p "You didn't crack the code! "
end

p "The answer is #{secret_code.join("")}"





