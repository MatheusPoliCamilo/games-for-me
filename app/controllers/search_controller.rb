require 'json'

class SearchController < ApplicationController
  def index
    response = OpenaiClient.new.call(movie: params[:search])
    games_names = response["choices"].map { |choice| choice["text"].delete("\n").split(', ') }.flatten
    recommended_games_steam_ids = games_names.map {|recommended_game| game_basic_infos(recommended_game)}

    @recommended_games = recommended_games_steam_ids.map do |game_id|
      next if game_id.nil?

      SteamClient.new(game_id).game_info
    end
  end

  def game_basic_infos(recommended_game)
    file = File.open("games.json")
    all_games = JSON.load(file)

    steam_game = all_games['applist']['apps'].find {|game| game["name"] == recommended_game}

    steam_game['appid'] if steam_game.present?
  end
end
