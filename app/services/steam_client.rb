require 'json'

class SteamClient
  include HTTParty
  base_uri 'store.steampowered.com/api'

  def initialize(app_id)
    @app_id = app_id
    @options = { query: { appids: app_id }, format: 'json', l: 'pt' }
  end

  def game_info
    response = self.class.get("/appdetails", @options)

    json = JSON.parse(response.body)

    puts "App id: #{@app_id}"
    puts "===" * 100

    json[@app_id.to_s]
  end
end
