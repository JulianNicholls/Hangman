require './hangmandata'

class HangmanGame

  attr_reader :word, :bad
  
  include HangmanData
  
# Initialise, either with a word or a selection from the word list

  def new_game( word = nil )
    @word = (word || random_word).upcase
    @done = false
    @bad  = []
    @good = []
  end
  
  
# Return the word with dashes for unguessed letters

  def word_as_dashes
    word = ''
    
    @word.split( // ).each do |c|
      word << ((is_good? c) ? "#{c} " : "_ ")
    end
    
    word
  end


# Return whether the word has been completely solved

  def solved?
    @word.split( // ).each do |c|
      return false unless is_good? c
    end
    
    true
  end
  

# Process the passed letter and add it to either 
# good or bad  

  def process_letter cur
    if( in_word? cur )
      @good << cur unless is_good? cur  # Don't duplicate
    else
      @bad << cur unless is_bad? cur  
    end
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

# Return the used letters

  def used
    @good + @bad
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

end

