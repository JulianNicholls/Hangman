require './hangmandata'

class HangmanGame

  include HangmanData
  
  
  @@show_title = true
  
# Initialise, either with a word or a selection from the word list

  def initialize( word = nil )
    @word = (word || random_word).upcase
    @done = false
    @bad  = []
    @good = []
  end

  
# Play one game
  
  def play
    show_title if @@show_title
    
    complete = false

    while !complete
      show_gallows
      complete = show_word || hung?
      if( !complete )
        show_bad
        get_letter
      end
    end
    
    finished
  end

  
# Show the gallows for the current number of used letters
  
  def show_gallows
    if bad_count > 0
      puts "\n\n" + GALLOWS[bad_count-1]
    end
  end


# Show the word, and return whether it's solved
  
  def show_word
    solved = true
    
    print "\nWord: "
    
    @word.split( // ).each do |c|
      if is_good? c
        print "#{c} "
      else
        print "_ "
        solved = false
      end
    end
    
    puts "\n\n"
    
    solved
  end

  
# Show the used letters

  def show_bad
    if bad_count != 0
      print "Used: "
      @bad.each { |c| print "#{c} " }
      puts "\n\n"
    end
  end


# Get a letter from the player
  
  def get_letter
    print "Letter? "
    cur = gets[0].upcase

    if( in_word? cur )
      @good << cur unless is_good? cur  # Don't duplicate
    else
      @bad << cur unless is_bad? cur  
    end
  end

  
# Tell the user well done, or...

  def finished
    if hung?
      puts "Aaargh! Fred was hanged.\nThe word was #@word.\n\n"
    else
      puts "Well done.\n\n"
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
    
    @@show_title = false
  end


# Return whether it's all over
  
  def hung?
    bad_count == GALLOWS.length
  end


# Choose a random word from the list
  
  def random_word
    WORDS[rand WORDS.length]
  end

  
# Return the number of used letters

  def bad_count
    @bad.length
  end


# Return whether the passed letter is in the word
  
  def in_word? letter
    @word.include? letter
  end
  
  
# Return whether the letter is in the word and has been entered by the player

  def is_good? letter
    @good.include? letter
  end
  
  
# Return whether a letter has been used, and wrong

  def is_bad? letter
    @bad.include? letter
  end

  
# Debug display of state

  def debug
    puts "Word: #@word"
    puts "Good: #@good"
    puts "Bad:  #@bad"
  end

end

