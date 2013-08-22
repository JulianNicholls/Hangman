class HangmanGame

  WORDS = [
    'system', 'crab', 'trivial', 'pursuit', 'apache', 'lives', 'cistern', 'english',
    'certificate', 'exits', 'xyphias', 'xylophone', 'zoology', 'rhythms', 'idiomatic',
    'knowhow', 'pioneer', 'universe', 'programme', 'programs', 'analogue', 'digitally',
    'employee', 'employers', 'quagmire', 'quizzes', 'quartz', 'systematic', 'education',
    'solarise', 'helicopters', 'rescue', 'aerials', 'aerie', 'cathodes', 'anode', 
    'electron', 'protons', 'neutron', 'positron', 'quarks', 'nucleus', 'capacitor',
    'capacitance', 'reluctance', 'impedance', 'resistors', 'resistance', 'examination',
    'cellphones', 'mobile', 'movies', 'cinema', 'countryside', 'landscape', 'woodland',
    'rural', 'archive', 'archival', 'virtual', 'camouflage', 'reluctant', 'jumper',
    'sweaters', 'pullover', 'fleece', 'spruce', 'automobile', 'aphid', 'needle',
    'zebras', 'economic', 'necrotic', 'completing', 'recycler'
  ]
  
  GALLOWS = [
    "\n\n\n\n\n\n------------",
    "\n |\n |\n |\n |\n |\n------------",
    " --------\n |\n |\n |\n |\n |\n------------",
    " --------\n |/\n |\n |\n |\n |\n------------",
    " --------\n |/     |\n |\n |\n |\n |\n------------",
    " --------\n |/     |\n |      o\n |\n |\n |\n------------",
    " --------\n |/     |\n |      o\n |      O\n |\n |\n------------",
    " --------\n |/     |\n |      o\n |     /O\n |\n |\n------------",
    " --------\n |/     |\n |      o\n |     /O\\\n |\n |\n------------",
    " --------\n |/     |\n |      o\n |     /O\\\n |     /\n |\n------------",
    " --------\n |/     |\n |      o\n |     /O\\\n |     / \\ \n |\n------------"
  ]

  def initialize( word = nil )
    @word = (word || random_word).upcase
    @done = false
    @bad  = []
    @good = []
  end

  def play
    complete = false

    while !complete
      show_gallows
      complete = show_word || hung?
      if( !complete )
        show_bad
        get_letter
      end
    end
    
    if hung?
      puts "Aaargh! Fred was hanged.\nThe word was #@word.\n\n"
    else
      puts "Well done.\n\n"
    end
  end

  def show_gallows
    if bad_count > 0
      puts "\n\n" + GALLOWS[bad_count-1]
    end
#    puts "Gallows: #{@bad.length}\n\n";
  end
  
  def show_word
    solved = true
    
    print "\nWord: "
    
    @word.split( // ).each do |c|
      if @good.include? c
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
  
  def hung?
    bad_count == 11
  end
  
  def get_letter
    print "Letter? "
    cur = gets[0].upcase

    if( @word.include? cur )
      @good << cur unless @good.include? cur
    else
      @bad << cur unless @bad.include? cur  # Don't duplicate
    end
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
end

