require "./hangmangame"

class TextGame < HangmanGame

  CLR   = "\e[2J"   # Clear screen
  HOME  = "\e[;H"   # Home Cursor
  
  def initialize
    @show_title = true;
  end
  
  def play_repeatedly
    again = true

    while again
      new_game
      play
      
      yesno = 'q'
      
      while !('YN'.include? yesno)
        print blue { bold { "Play Again? " } }
        yesno = gets[0].upcase
      end
      
      again = (yesno == 'Y')
    end
  end

  
# Play one game
  
  def play
    show_title if @show_title
    
    complete = false

    while !complete
      print CLR + HOME   
      show_gallows
      complete = show_word || hung?
      if !complete
        show_bad
        get_letter
      end
    end
    
    finished
  end

  
# Show the gallows for the current number of used letters
  
  def show_gallows
    if bad_count > 0
      puts "\n" + GALLOWS[bad_count-1]
    end
  end


# Show the word, and return whether it's solved
  
  def show_word
    puts "\nWord: " + blue { bold { word_as_dashes } } + "\n\n"    
    solved?
  end

  
# Show the used letters

  def show_bad
    if bad_count != 0
      print "Used: "
      @bad.each { |c| print red { bold { "#{c} " } } }
      puts "\n\n"
    end
  end


# Get a letter from the player
  
  def get_letter
    print "Letter? "
    cur = gets[0].upcase

    process_letter cur
  end

  
# Tell the user well done, or...

  def finished
    if hung?
      puts red { bold { "Aaargh! Fred was hanged.\nThe word was #@word.\n\n" } }
    else
      puts green { bold { "Well done.\n\n" } }
    end
    
    !hung?
  end


# Show the title screen, and suppress it for following runs

  def show_title
    puts "-----------------------------------------"
    puts "HANGMAN by Julian Nicholls, August 2013"
    puts "      -----------------------"
    puts "Selecting from #{WORDS.length} words."
    puts "-----------------------------------------\n\n"
    
    @show_title = false
  end


  def debug
    puts "Word: #@word"
    puts "Good: #@good"
    puts "Bad:  #@bad"
  end

end

game = TextGame.new
game.play_repeatedly
