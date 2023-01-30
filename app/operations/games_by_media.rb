require 'active_support/core_ext/hash/keys'

class GamesByMedia
  def call(movie:)
    ai_games = OpenaiClient.new.call(movie)

    return if ai_games.nil? || ai_games.empty?

    games_full_info = games_app_ids(ai_games).map do |game_app_id|
      response = steam_data(game_app_id)

      response['data'] # Steam's return
    end.compact

    parse_response(games_full_info)
  end

  def games_app_ids(response)
    response['choices'].first['text'].scan(/(\d+)\.(.*)\((\d+)\)/).map { |_, _, app_id| app_id.to_i }
  end

  def steam_data(app_id)
    SteamClient.new(app_id).game_info
  end

  def parse_response(response)
    response.map(&:deep_symbolize_keys)
  end
end