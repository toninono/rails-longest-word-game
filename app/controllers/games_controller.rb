require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }

  end

  def score
    @word = params[:word].upcase
    data = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    words = JSON.parse(data)
    @letters = params[:letters]
    if words['found']
      letters = @word.split('')
      @result = if letters.all? { |x| params[:letters].include?(x) == true }
                  "Congratulations #{@word} is a valid English word!"
                else
                  "Sorry, but #{@word} can’t be built out of #{@letters}"
                end
    else
      @result = "Sorry, but #{@word} does not seem to be a valid English word..."
    end
  end

end

