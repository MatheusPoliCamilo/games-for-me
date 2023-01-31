require 'json'

class SearchController < ApplicationController
  def index
    @recommended_games = GamesByMedia.new.call(media_type: params[:media_type], media: params[:media])
  end
end
