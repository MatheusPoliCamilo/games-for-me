class SearchController < ApplicationController
  def index
    response = Client.new.call(movie: params[:search])
    @movies = response["choices"].map { |choice| choice["text"] }
  end
end
