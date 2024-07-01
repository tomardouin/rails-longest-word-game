require 'open-uri'
require 'json'

class GamesController < ApplicationController

    def new
        @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    end

    def score
        @letters = params[:letters].split
        if included?(params[:word].upcase, @letters)
            if english_word?(params[:word])
                @result = "Congratulations! '#{params[:word]}' is a valid English word!"
            else
                @result = "Sorry but '#{params[:word]}' does not seem to be a valid English word..."
            end
        else
            @result = "Sorry but '#{params[:word]}' can't be built out of '#{params[:letters]}'"
        end
    end

    def english_word?(word)
        response = URI.parse("https://dictionary.lewagon.com/#{word}")
        json = JSON.parse(response.read)
        return json['found']
    end

    def included?(guess, letters)
        guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
    end
end
