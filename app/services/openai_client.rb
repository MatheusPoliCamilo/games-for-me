class OpenaiClient
  def initialize
    @client = OpenAI::Client.new
  end

  def call(media_type, media)
    @client.completions(
      parameters: {
        model: "text-davinci-003",
        prompt: prompt(media_type, media),
        max_tokens: 1000,
        temperature: 1,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0
      }
    )
  end

  def prompt(media_type, media)
    "Return a list of 20 games (names only) that is in steam store that are similar to the #{media_type} '#{media}'"
  end
end
