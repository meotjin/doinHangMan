require 'open-uri'

class Dictionary
  @@words = URI.open('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt').readlines

  def self.get_word
    no_of_words = @@words.count
    begin
      random_word = @@words[rand(no_of_words)]
      raise if random_word.length > 12 || random_word.length < 5
    rescue StandardError
      retry
    else
      random_word
    end
  end
end
