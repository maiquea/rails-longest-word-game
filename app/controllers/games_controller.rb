require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    # TODO: generate random grid of letters
    @letters = []
    for i in 1..10
      @letters << ('A'..'Z').to_a[rand(26)]
    end
  end

  def score
    # raise

    grid = params[:letters].split(' ')
     attempt = params[:word]
    

    def run_game(attempt, grid, start_time, end_time)
      # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
      result = {}
      result[:time] = end_time - start_time
      if check_grid(attempt.upcase, grid)
        result_json_hash = check_word(attempt)
        if result_json_hash["found"] == true
          # result[:score] = compute_score(attempt.length, result[:time])
          result[:score] = 0
          # puts result[:score]
          result[:message] = "Well Done!"
        else
          result[:score] = 0
          result[:message] = "not an english word"
        end
      else
        result[:score] = 0
        result[:message] = "Word not in the grid"
      end
      return result
    end

    def check_word(attempt)
      my_hash = {}
      URI.open("https://wagon-dictionary.herokuapp.com/#{attempt}") do |f|
        f.each_line { |line| my_hash = JSON.parse(line) }
      end
      return my_hash
    end

    def check_grid(attempt, grid)
      for i in 0..attempt.length - 1
        grid.index(attempt[i]).nil? ? (return false) : grid.delete_at(grid.index(attempt[i]))
      end
      return true
    end

    @results = run_game(attempt, grid, 0, 0)
    # raise
  end

end
