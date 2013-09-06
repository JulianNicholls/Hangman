require "term/ansicolor"

module HangmanData

  include Term::ANSIColor
  
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
  
  LAND = Term::ANSIColor.yellow { "------------" }
  TOP  = Term::ANSIColor.yellow { " --------\n" }
  
  GALLOWS = [
    "\n\n\n\n\n\n" + LAND,
    "\n |\n |\n |\n |\n |\n" + LAND,
    TOP + " |\n |\n |\n |\n |\n" + LAND,
    TOP + " |/\n |\n |\n |\n |\n" + LAND,
    TOP + " |/     |\n |\n |\n |\n |\n" + LAND,
    TOP + " |/     |\n |      o\n |\n |\n |\n" + LAND,
    TOP + " |/     |\n |      o\n |      O\n |\n |\n" + LAND,
    TOP + " |/     |\n |      o\n |     /O\n |\n |\n" + LAND,
    TOP + " |/     |\n |      o\n |     /O\\\n |\n |\n" + LAND,
    TOP + " |/     |\n |      o\n |     /O\\\n |     /\n |\n" + LAND,
    TOP + " |/     |\n |      o\n |     /O\\\n |     / \\ \n |\n" + LAND
  ]

end
