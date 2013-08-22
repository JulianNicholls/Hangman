require './hangmandata'


class HangmanGame

  include HangmanData

  def initialize( word = nil )
    @word = (word || random_word).upcase
    @done = false
    @bad  = []
    @good = []
  end

  def play
    print "Words: #{WORDS.length}\n\n"
    
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

  def show_gallows
    if bad_count > 0
      puts "\n\n" + GALLOWS[bad_count-1]
    end
  end
  
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

  def show_bad
    if bad_count != 0
      print "Used: "
      @bad.each { |c| print "#{c} " }
      puts "\n\n"
    end
  end
  
  def get_letter
    print "Letter? "
    cur = gets[0].upcase

    if( in_word? cur )
      @good << cur unless is_good? cur  # Don't duplicate
    else
      @bad << cur unless is_bad? cur  
    end
  end

  def finished
    if hung?
      puts "Aaargh! Fred was hanged.\nThe word was #@word.\n\n"
    else
      puts "Well done.\n\n"
    end
    
    !hung?
  end
  
  def hung?
    bad_count == GALLOWS.length
  end
  
  def debug
    puts "Word: #@word"
    puts "Good: #@good"
    puts "Bad:  #@bad"
  end

private

  def random_word
    WORDS[rand WORDS.length]
  end

  def bad_count
    @bad.length
  end
  
  def in_word? char
    @word.include? char
  end
  
  def is_good? char
    @good.include? char
  end
  
  def is_bad? char
    @bad.include? char
  end
end

