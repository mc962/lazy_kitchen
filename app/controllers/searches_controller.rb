class SearchesController < ApplicationController
  def index
    @results = Search.home_autocomplete(params[:query])

    render :index
  end
end
