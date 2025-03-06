
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
  eval == CORRECT_GUESS ? true : false 
end

# game section

def user_plays()
  secret_code =  generate_code()
  tries = 1 
  eval = ''

  puts "You are now the CODEBREAKER"
  puts "The valid colors are r,g,b,y,m,c"
  puts "The code is a 4-COLOR combination of the above"
  puts "Your guess will be evaluated as follows: "
  puts "X - if color and it's position is correct"
  puts "x - if color is correct and it's position is wrong"
  puts "You have #{TRIES_LIMIT} tries"

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
end

def pc_plays()
  tries = 1
  eval = ''

  puts "You are now the CODEMAKER"
  puts "The valid colors are r,g,b,y,m,c"
  puts "The code is a 4-COLOR combination of the above"
  puts "You will supply the code and the computer will try to guess"
  puts "In #{TRIES_LIMIT} tries"

  secret_code = get_player_made_code().chars

  puts "Code #{secret_code} accepted!"

  #now time for the computer to guess
  until tries == TRIES_LIMIT or guess_correct?(eval) do
    computer_guess = generate_code()

    puts "The computer tries #{computer_guess}"
    eval = evaluate_guess(computer_guess.join, secret_code)

    p "Guess number #{tries}, guess: #{computer_guess} result: #{eval}"

    tries += 1
  end
 
  if guess_correct?(eval)
    p "The computer cracked the code!"
  elsif
    p "The computer didn't crack the code! "
  end

end

def get_player_made_code()
  loop do
    print "What is the code?: "
    secret_code = gets.chomp()

    return secret_code if secret_code.match?(/^[rgbymc]{4}$/)

    puts "Please select a four-letter combination of [r,g,b,y,m,c]"
  end
end

# if computer player
#   user will provide secret code
#   computer will supply guesses
#
# if user player
#   computer will generate secret code
#   player will supply guesses
#
#   keep it simple!

def get_player_choice_input()
  loop do
    print "What's your choice?: "
    choice = gets.chomp[0]

    return choice if choice == '1' or choice == '2' 

    puts 'Please enter 1 or 2'

    end
end

#Intro menu
puts "This is Mastermind, a game of cracking codes"
puts "Please select how you'd like to play"
puts "[1] I want to be the codebreaker"
puts "[2] I want to be the codemaker"

choice = get_player_choice_input()
puts "Your choice is #{choice}"

#game start
if choice.to_i == 1
  user_plays() 
elsif choice.to_i == 2
  pc_plays()
end






