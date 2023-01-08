require 'json'

class Hangman
  attr_reader :word, :lives, :geusses

  def initialize(word, lives = 6, geusses = [])
    @word = word.split('')
    @lives = lives
    @geusses = geusses
  end

  def geuss(char)
    @geusses.push char
    check_geuss char
  end

  def save_to_file(name)
    json name
  end

  def self.read_json(path)
    return nil unless File.exist? path

    json_file = File.read path
    json = JSON.parse json_file
    Hangman.new(json['word'], json['lives'], json['geusses'])
  end

  def dead?
    @lives <= 0
  end

  def win?
    @word == @geusses
  end

  private

  def check_geuss(char)
    @lives -= 1 unless @word.include? char
  end

  def json(name)
    hash = {
      word: @word.join,
      geusses: @geusses,
      lives: @lives
    }

    file = File.open("./saves/#{name}.json", 'w')
    file.write(hash.to_json)
    file.close
  end
end
