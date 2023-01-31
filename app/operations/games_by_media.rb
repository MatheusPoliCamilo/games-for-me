require 'active_support/core_ext/hash/keys'
require 'json'

class GamesByMedia
  def initialize
    file = File.open('games.json')
    json = JSON.load(file)

    @steam_games = json['applist']['apps']
  end

  def call(media:)
    ai_games = OpenaiClient.new.call(media)

    return if ai_games.nil? || ai_games.empty?

    games_names = ai_games["choices"].map do |choice|
      choice["text"].split("\n")
    end.flatten.compact_blank.map do |text|
      text.gsub(/^\d+.|\)/, '').strip
    end

    games_full_info = games_names.map do |recommended_game|
      game_app_id = game_app_id(recommended_game)

      next if game_app_id.nil?

      response = steam_data(game_app_id)

      response['data'] # Steam's return
    end.compact

    parse_response(games_full_info)
  end

  def game_app_id(game_name)
    game = @steam_games.find {|game| game["name"].strip.downcase == game_name.downcase}

    return game['appid'] if game.present?

    nil
  end

  def steam_data(app_id)
    SteamClient.new(app_id).game_info
  end

  def parse_response(response)
    response.map(&:deep_symbolize_keys)
  end
end