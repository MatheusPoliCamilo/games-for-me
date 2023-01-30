class OpenaiClient
  def initialize
    @client = OpenAI::Client.new
  end

  def call(movie:)
    @client.completions(
      parameters: {
        model: "text-davinci-003",
        prompt: "Me dê um array de 20 jogos de PC (somente os nomes), sem números indicando suas posições, separados por vírgula, que sejam semelhantes ao filme '#{movie}'.",
        max_tokens: 500
      }
    )
  end
end
