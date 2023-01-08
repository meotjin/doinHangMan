require_relative 'hangman'
require_relative 'display'
require_relative 'dictionary'
class Game
  include Display

  attr_reader :hangman

  def initialize
    @hangman = Hangman.new(Dictionary.get_word)
  end

  def play
    check_if_load

    while !@hangman.dead? && !@hangman.win?
      show(@hangman)
      puts "\n\nmake a geuss!(press '=' to save the game)"
      begin
        input = gets.chomp[0]
        raise if input == '='
      rescue StandardError
        puts 'enter a file name'
        @hangman.save_to_file(gets.chomp)
        puts 'saved! now take a geuss'
        retry
      else
        @hangman.geuss(input)
      end
    end
    if @hangman.dead?
      puts 'you lost :('
    else
      puts 'You Win :)'
    end

    puts 'the word was ->'
    puts @hangman.word.join
  end

  private

  def check_if_load
    puts 'do you want to load a save?(y/n)'
    begin
      input = gets.chomp[0]
      raise if input != 'y' && input != 'n'
    rescue StandardError
      retry
    else
      input == 'y' ? load : true
    end
  end

  def load
    puts 'please enter the save-file address->'
    begin
      hangman = Hangman.read_json(gets.chomp)
      raise if hangman.nil?
    rescue StandardError
      puts 'that file doesnt exist. try again'
      retry
    else
      puts 'file successfuly loaded!'
      @hangman = hangman
    end
  end
end
