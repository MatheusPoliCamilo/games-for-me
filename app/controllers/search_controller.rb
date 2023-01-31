require 'json'

class SearchController < ApplicationController
  def index
    @recommended_games = GamesByMedia.new.call(media_type: params[:media_type], media: media)
  end

  private

  def media
    JSON.parse(params[:media]).map { |hash| hash["value"] }.join(", ")
  end
end
