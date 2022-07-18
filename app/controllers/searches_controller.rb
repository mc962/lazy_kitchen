class SearchesController < ApplicationController
  def index
    @results = Search.home_autocomplete(params[:query])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("autocomplete",
                              partial: "searches/results",
                              locals: { results: @results })
        ]
      end
    end
    # render :index
  end
end
