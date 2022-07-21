class SearchesController < ApplicationController
  def index
    data = Search::Client.recipes(
      params[:query],
      page: params[:page]
    )
    @results = Kaminari.paginate_array(
      data
    ).page(params[:page]).per(Kaminari.config.default_per_page)

    render :index
  end
end
