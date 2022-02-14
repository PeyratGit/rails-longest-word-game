require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    letters = params[:letters].split("")
    @guess = params[:guess]
    @guess_arr = @guess.split("")
    @api_result = URI.open("https://wagon-dictionary.herokuapp.com/#{@guess}")
    found = JSON.parse(@api_result.read)['found']
    in_grid = true
    @guess_arr.each do |letter|
      if letters.include? letter
        letters.slice!(letters.index(letter))
      else
        in_grid = false
      end
    end
    if in_grid == false
      @message = "Sorry but #{@guess} can't be built out of #{letters.join(" | ").upcase}"
    elsif in_grid == true && found == false
      @message = "Sorry but #{@guess} does not seem to be a valid English word"
    else
      @message = "Congratulations! #{@guess} is a valid English word !"
    end
  end
end
