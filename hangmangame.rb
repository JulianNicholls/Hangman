require 'hangmandata'

# The Hangman game engine
class HangmanGame
  attr_reader :word, :bad

  include HangmanData

  # Load word list, and keep, if asked. The web version has to load the word
  # list on demand

  def initialize(keep_list = :keep)
    @wordlist = []

    File.foreach('words.txt') { |line| @wordlist << line.chomp }

    @word_count = @wordlist.length
    @wordlist   = [] unless keep_list == :keep
  end

  # Start a new game, either with a word or a selection from the word list

  def new_game(word = nil)
    @done = false
    @bad  = []
    @good = []

    @word = (word || random_word).upcase
  end

  # Return the word with dashes for unguessed letters

  def word_as_dashes
    word = ''

    @word.each_char do |char|
      word << (good?(char) ? "#{char} " : '_ ')
    end

    word
  end

  # Return whether the word has been completely solved

  def solved?
    @word.each_char.all? { |char| good? char }
  end

  # Process the passed letter and add it to either good or bad

  def process_letter(cur)
    if in_word? cur
      @good << cur unless good? cur
    else
      @bad << cur unless bad? cur
    end
  end

  # Return whether it's all over

  def hung?
    bad_count == GALLOWS.length
  end

  # Choose a random word from the list or from the file, if the list wasn't
  # retained in initialize.

  def random_word
    index = rand @word_count

    # If the word list has been initialized (text mode), return a word

    return @wordlist[index] unless @wordlist.length == 0

    # Otherwise, we need to choose a word by reading a random number of lines
    # into the word file

    word = ''

    File.open('words.txt') do |file|
      index.times { word = file.gets.chomp }
    end

    word
  end

  # Return the number of used letters

  def bad_count
    @bad.length
  end

  # Return whether the passed letter is in the word

  def in_word?(letter)
    @word.include? letter
  end

  # Return all the used letters

  def used
    @good + @bad
  end

  # Return whether the letter is in the word and has been entered by the player

  def good?(letter)
    @good.include? letter
  end

  # Return whether a letter has been used, and wrong

  def bad?(letter)
    @bad.include? letter
  end
end
