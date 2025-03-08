
require_relative 'lib/mastermind'
require_relative 'lib/user_plays'
require_relative 'lib/codebreaker'
require_relative 'lib/pc_plays'

##############################

#Main

#############################

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
  game2 = UserPlaysMM.new
  game2.start()
elsif choice.to_i == 2
  game3 = PCPlaysMM.new
  game3.start()
end

