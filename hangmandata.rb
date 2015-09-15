require 'term/ansicolor'

# Data for the text Hangman game.
module HangmanData
  include Term::ANSIColor

  LAND = Term::ANSIColor.yellow { '------------' }
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
