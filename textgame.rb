require "./hangmangame"

class TextGame < HangmanGame

  CLR   = "\e[2J"   # Clear screen
  HOME  = "\e[;H"   # Home Cursor
 
# Initialise by enabling the initial title panel, loading
# and caching the word list
 
  def initialize
    @show_title = true;

    print "Loading... "
    super
  end
  
# Play until the user wants out.

  def play_repeatedly
    show_title if @show_title
    
    again = true

    while again
      new_game
      play
      
      yesno = 'q'
      
      while !('YN'.include? yesno)
        print cyan { bold { "Play Again? " } }
        yesno = gets[0].upcase
      end
      
      again = (yesno == 'Y')
    end
  end

  
# Play one game
  
  def play
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
    puts "\nWord: " + cyan { bold { word_as_dashes } } + "\n\n"    
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
    print yellow { bold { "Letter? " } }
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
    puts "\n"
    puts "----------------------------------------"
    puts "HANGMAN by Julian Nicholls, Aug-Sep 2013"
    puts "      -----------------------"
    puts "    Selecting from #{@wordlist.length} words."
    puts "----------------------------------------\n\n"
    
    sleep 3
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
