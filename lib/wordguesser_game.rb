class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    if letter == nil || letter.empty? || (/[a-z]/i =~ letter) == nil
      raise ArgumentError
    end
    letter = letter.downcase
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
  end

  def word_with_guesses
    ans = ""

    for i in 0...@word.length do
      if @guesses.include?(@word[i])
        ans += @word[i]
      else
        ans += '-'
      end
    end
    return ans
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    end
    if @wrong_guesses.length >= 7
      return :lose
    end
    return :play
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
