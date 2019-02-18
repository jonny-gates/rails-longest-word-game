require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    letters_allowed = params[:letters_allowed].split("")
    @answer = params[:answer]

    if check_in_grid(@answer.upcase, letters_allowed) == false
      @response = "Sorry but #{@answer} can't be built"
    elsif valid_word(@answer) == false
      @response = "In the grid, but not a valid word"
    else
      @response = "That's a word alright, #{@answer.length} points!"
      session[:score] ? session[:score] += @answer.length : session[:score] = @answer.length
    end

    @score = session[:score] ? session[:score] : 0
  end

  def check_in_grid(answer, letters_allowed)
    answer_arr = answer.split("")
    answer_arr.each do |letter|
      letter_in_answer = answer_arr.count(letter)
      letter_in_grid = letters_allowed.count(letter)
      return false unless letter_in_answer <= letter_in_grid
    end
  end

  def valid_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    result = JSON.parse(response)
    result["found"]
  end
end
