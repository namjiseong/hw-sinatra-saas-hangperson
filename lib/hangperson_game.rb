class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(crt)
    a = ('a'..'z')
    b = ('A'..'Z')
    if crt.nil? or crt.empty?
      raise ArgumentError
    end
    unless a.include? crt or b.include? crt
      raise ArgumentError
    end
    
    crt.downcase!
    
    if guesses.include? crt or wrong_guesses.include? crt
      return false
    elsif @word.include? crt
      @guesses << crt
    else
      @wrong_guesses << crt
    end
    return true
  end
  
  def word_with_guesses
    str = ''
    @word.each_char do |x|
      if @guesses.include? x
        str << x
      else
        str << '-'
      end
    end
    str
  end
  
  def check_win_or_lose
    unless word_with_guesses.include? '-'
      return :win
    end
    if wrong_guesses.length >= 7
      return :lose
    end
    return :play
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
#wo4snakes
end
