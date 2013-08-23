require "./hangmangame"

again = true

while again
  game = HangmanGame.new
  game.play
  
  yesno = 'q'
  
  while !('YN'.include? yesno)
    print "\nPlay Again? "
    yesno = gets[0].upcase
  end
  
  again = (yesno == 'Y')
end
