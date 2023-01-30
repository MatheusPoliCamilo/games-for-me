class OpenaiClient
  def initialize
    @client = OpenAI::Client.new
  end

  def call(movie:)
    @client.completions(
      parameters: {
        model: "text-davinci-003",
        prompt: "Return a list of 20 computer games (names only) that are similar to the movie '#{movie}'.",
        max_tokens: 500
      }
    )
  end
end
