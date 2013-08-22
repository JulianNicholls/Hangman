class HangmanGame

  WORDS = [
    'system', 'crab', 'trivial', 'pursuit', 'apache', 'lives', 'cistern', 'english',
    'certificate', 'exits', 'xyphias', 'xylophone', 'zoology', 'rhythms', 'idiomatic',
    'knowhow', 'pioneer', 'universe', 'programme', 'programs', 'analogue', 'digitally',
    'employee', 'employers', 'quagmire', 'quizzes', 'quartz', 'systematic', 'education',
    'solarise', 'helicopters', 'rescue', 'aerials', 'aerie', 'cathodes', 'anode', 
    'electron', 'protons', 'neutron', 'positron', 'quarks', 'nucleus', 'capacitor',
    'capacitance', 'reluctance', 'impedance', 'resistors', 'resistance', 'examination',
    'cellphones', 'mobile', 'movies', 'cinema', 'countryside', 'landscape', 
    'woodland', 'rugby', 'golf', 'unhinged', 'ruby', 'smoke', 'weather', 'stationer',
    'rural', 'archive', 'archival', 'virtual', 'camouflage', 'reluctant', 'jumper',
    'sweaters', 'pullover', 'fleece', 'spruce', 'automobile', 'aphid', 'needle',
    'zebras', 'economic', 'necrotic', 'completing', 'recycler', 'revolved', 
    'standard','brother', 'daughter', 'hopeless', 'provider', 'telephones', 
    'television', 'telescopic', 'scope', 'vision', 'ecru', 'oreo', 'football',
    'sesquipedalian', 'elongates', 'ungulate', 'okapi', 'coati', 'kangaroo',
    'joey', 'wallaby', 'puma', 'lynxes', 'ocelot', 'leopard', 'serval', 'giraffe',
    'penguin', 'hippopotamus', 'genius', 'aardvark', 'badgers', 'marmoset',
    'exercise', 'machinery', 'factorise', 'factory', 'olfactory', 'volumatic',
    'vacuumed', 'spraying', 'squeezing', 'blowpipe', 'curare', 'poisons',
    'winglike', 'angelic', 'comedic', 'irritation', 'inguinal', 'appendices',
    'hepatic', 'kidneys', 'herniated', 'swallow', 'thoroughfare', 'devastating',
    'lymph', 'optical', 'alphabetic', 'antiseptic', 'disinfectant', 'staircases',
    'alarmist', 'preventative', 'huawei', 'siemens', 'ohms', 'ampere', 'coulomb',
    'microfarad', 'millihenry', 'gauss', 'radioactivity', 'biological', 'portrait',
    'landscaped', 'megajoule', 'kilowatt', 'ergonomically', 'armchair', 'physical',
    'quantify', 'hygrometer', 'surface', 'tension', 'ecstasy', 'causeway', 
    'bargain', 'controlling', 'trolled', 'rococo', 'ornately', 'nihilistic',
    'hospice', 'ambulances', 'pulmonary', 'deliberations', 'magazine', 'octopodes',
    'directory', 'expertly', 'spectacular', 'medallion', 'knitting', 'practicality',
    'ursine', 'lupine', 'pinnacle', 'purchased', 'moustaches', 'hairstyle', 
    'victorian', 'georgian', 'transparence', 'translucent', 'opaquely', 'adze',
    'zeolite', 'coined', 'millinery', 'antiques', 'philately', 'numismatist',
    'tutorial', 'beginner', 'intermediate', 'advancing', 'abalone', 'nacre',
    'questionable', 'irascible', 'erasure', 'sundial', 'eggtimer', 'shadowing',
    'numeral', 'googol', 'googolplex', 'bronze', 'verdigris', 'hundreds', 'cheapened',
    'toughening', 'hobnails', 'sabotage', 'ascot', 'brogue', 'trinkets', 'patina',
    'stylistic', 'horticulture', 'apiary', 'aviaries', 'scissors', 'hundredth',
    'hinged', 'hoes', 'joystick', 'wrapped', 'dividers', 'encompass', 'endeavour',
    'honoured', 'oscillator', 'enthroning', 'editor', 'notepad', 'wordless',
    'briefcase', 'divan', 'sedan', 'coupes', 'tongues', 'invasion', 'alienated',
    'healthy', 'adit', 'timber', 'asphyiated', 'vermin', 'radon', 'hydrogen',
    'mendeleevium', 'molybdenum', 'effluvium', 'rubidium', 'clumps', 'glimpsing',
    'obscured', 'ikea', 'dictionary', 'thesaurus', 'cyclopaedia', 'omnipotent',
    'auctioned', 'welsh', 'candlewick', 'bedspread', 'oriental', 'auctioneer',
    'telephony',
    
    'finality'
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
      @good << cur unless is_good? cur
    else
      @bad << cur unless is_bad? cur  # Don't duplicate
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

