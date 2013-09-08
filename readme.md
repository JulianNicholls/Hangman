# Hangman in Ruby

This is an implementation of the game Hangman. The hangman engine is in
hangmangame.rb. The words used, and the gallows for the text version are in
hangmandata.rb.

## Versions

textgame.rb is a command-line version which uses the gem 
[term-ansicolor](http://flori.github.io/term-ansicolor/) to add a
little colour to the display. 

webgame.rb is a [Sinatra](http://www.sinatrarb.com/) version, 
using [SASS](http://sass-lang.com/) and [Slim](http://slim-lang.com/).

## Word list

This has now been updated to use a word list constructed from
Kevin Atkinson's [wordlist page](http://wordlist.sourceforge.net/). 
I have included the whole copyright file that comes with the download, since
all the component word lists have ultimately been placed in the public domain, 
but there are a number of different statements of copyright contained. Clearly,
I am deeply in Kevin's debt for the word list and acknowledge the sterling work
that he has done.

The wordlist that I have chosen to construct from his files is:

- Level 60, with...
- English and British up to variant 1.
- No abbreviations, proper names, Roman numerals, and hacker words. 
- Word lengths 4 to 9.
