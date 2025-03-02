puts "This is a Mastermind Game"
puts "Can you break the code?"

CODE_ELEMENTS = ['r','g','b','y'].freeze
CODE_LENGTH = 4
TRIES = 4

def generate_code()
  randy = []
  CODE_LENGTH.times { randy << CODE_ELEMENTS[rand(CODE_ELEMENTS.length)]}
  randy
end

p generate_code()


