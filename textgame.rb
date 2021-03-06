#!/usr/bin/env ruby -I.

require 'hangmangame'

# Run the Hangman text game
class TextGame < HangmanGame
  CLR   = "\e[2J"   # Clear screen
  HOME  = "\e[;H"   # Home Cursor

  # Initialise by enabling the initial title panel, loading and caching
  # the word list

  def initialize
    @show_title = true

    print 'Loading... '
    super
  end

  # Play until the user wants out.

  def play_repeatedly
    show_title if @show_title

    loop do
      new_game
      play

      break unless yesno
    end
  end

  def yesno
    resp = ''

    loop do
      print cyan, bold, 'Play Again? '
      resp = gets[0].upcase
      break if 'YN'.include? resp
    end

    resp == 'Y'
  end

  # Play one game

  def play
    loop do
      print CLR + HOME
      show_gallows
      break if show_word || hung?

      show_bad
      enter_letter
    end

    finished
  end

  # Show the gallows for the current number of used letters

  def show_gallows
    puts "\n" + GALLOWS[bad_count - 1] if bad_count > 0
  end

  # Show the word, and return whether it's solved

  def show_word
    puts "\nWord: " + cyan + bold + word_as_dashes + "\n\n"
    solved?
  end

  # Show the used letters

  def show_bad
    return if bad_count == 0

    print 'Used: ', red, bold
    @bad.each { |char| print "#{char} " }
    puts "\n\n"
  end

  # Get a letter from the player

  def enter_letter
    print yellow, bold, 'Letter? '
    cur = read_char.upcase

    process_letter cur
  end

  def read_char
    system 'stty raw -echo'
    STDIN.getc
  ensure
    system 'stty -raw echo'
  end

  # Tell the user well done, or...

  def finished
    if hung?
      puts red, bold, "Aaargh! Fred was hanged.\nThe word was #{@word}.\n\n"
    else
      puts green, bold, "Well done.\n\n"
    end

    !hung?
  end

  # Show the title screen, and suppress it for following runs

  def show_title
    puts <<END

----------------------------------------
HANGMAN by Julian Nicholls, Aug-Dec 2013
      -----------------------
    Selecting from #{@wordlist.length} words.
----------------------------------------\n\n
END
    sleep 3
    @show_title = false
  end

  def debug
    puts "Word: #{@word}"
    puts "Good: #{@good}"
    puts "Bad:  #{@bad}"
  end
end

game = TextGame.new
game.play_repeatedly
