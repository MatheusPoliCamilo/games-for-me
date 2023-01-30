class SearchController < ApplicationController
  def index
    response = OpenaiClient.new.call(movie: params[:search])
    @movies = response["choices"].map { |choice| choice["text"].delete("\n").split(', ') }.flatten

    
  end
end
