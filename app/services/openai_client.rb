class OpenaiClient
  def initialize
    @client = OpenAI::Client.new
  end

  def call(media)
    @client.completions(
      parameters: {
        model: "text-davinci-003",
        prompt: prompt(media),
        max_tokens: 4000
      }
    )
  end

  def prompt(media)
    "Return a list of 5 games (names only and steam appid) that is in nuuvem store that are similar to the movie '#{media}'"
  end
end
