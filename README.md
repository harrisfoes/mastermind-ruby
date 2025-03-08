# Mastermind-Ruby

This is the implementation of the mastermind game in ruby.
It is a project from the Odin Project curriculum

## Notes and File Structure:

``` ruby
main_old.rb
#=> is the old implementation, deprecated and purely procedural

#=> The rest of the files are in use and now in class form

mastermind.rb 
#=> main mastermind base class

user_plays.rb 
#=> when the user chooses to play

pc_plays_rb   
#=> when the user chooses to provide the secret 

codebreaker.rb 
#=> For the record, Chatgpt wrote this. The codebreaker module is optional and also not within the scope of my current learning (OOP concepts and refactoring), so I decided to defer it to AI so I can play around for curiosity. To be fair it's super efficient and can crack the code at around seven tries. 
```


## Game details:

colors accepted = [r,g,b,y,m,c] : char
tries allowed = 10

