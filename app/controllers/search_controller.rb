class SearchController < ApplicationController
  def index
    @recommended_games = GamesByMedia.new.call(media: params[:search])
  end
end
