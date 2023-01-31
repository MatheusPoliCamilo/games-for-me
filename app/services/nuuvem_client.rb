require 'json'

class NuuvemClient
  include HTTParty
  base_uri 'manager.nuuvem.co/api/v2/'

  def initialize
    @options = {
      headers: {
        "Authorization" => "Bearer #{ENV['NUUVEM_API_TOKEN']}"
      }
    }
  end

  def game_info(game_name)
    product_by_name = self.class.get("/products", @options.merge({query: { filter: {name: "eq,#{game_name}" }}}))

    return if product_by_name.body.present? && !product_by_name.body['errors']

    product_by_name = JSON.parse(product_by_name.body)

    return if product_by_name['data'].empty?

    response = self.class.get("/products/#{product_by_name['data'].first['id']}", @options)

    JSON.parse(response.body)
  end
end
