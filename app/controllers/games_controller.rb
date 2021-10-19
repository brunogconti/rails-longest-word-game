class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    word_array = params[:word].downcase.chars
    letters_array = params[:letters].split(' ')

    uri = URI("https://wagon-dictionary.herokuapp.com/#{params[:word].downcase}")
    response = Net::HTTP.get(uri)
    dictionary = JSON.parse(response)

    if !word_array.all? { |e| letters_array.include?(e) }
      @result = "Sorry but '#{params[:word]}' can't be build out of '#{params[:letters]}'"
    elsif dictionary['found']
      @result = "Congratulations! #{params[:word]} is a valid word!"
    else
      @result = "Sorry but #{params[:word]} does not seem to be a valid english word..."
    end
  end
end
