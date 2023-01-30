require 'json'

class SearchController < ApplicationController
  def index
    @recommended_games = GamesByMedia.new.call(movie: params[:search])
  end
end
