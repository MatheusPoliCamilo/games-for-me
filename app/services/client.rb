class Client
  def initialize
    @client = OpenAI::Client.new
  end

  def call(movie:)
    @client.completions(
      parameters: {
        model: "text-davinci-003",
        prompt: "Me recomende 10 jogos separados por vírgula, que sejam semelhantes ao filme '#{movie}'.",
        max_tokens: 150
      }
    )
  end
end
