require_relative 'hangman'

module Display
  def show(hangman)
    puts ''
    hangman.word.each do |letter|
      text = hangman.geusses.include?(letter) ? "#{letter} " : '-  '
      print text
    end
    puts "     lives left: #{hangman.lives}"
  end
end
