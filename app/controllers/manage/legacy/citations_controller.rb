class Manage::Legacy::CitationsController < Manage::Legacy::ApplicationController
  def show
    @citation = Citation.where(recipe_id: params[:recipe_id]).find(params[:id])
    authorize! @citation

    render :show
  end

  def new
    @citation = Citation.new(recipe_id: params[:recipe_id])
    authorize!

    render :new
  end

  def create
    @citation = Citation.new(citation_params)
    authorize! @citation

    if @citation.save
      flash.notice = 'Citation created successfully.'
      redirect_to manage_legacy_recipe_citation_path(@citation)
    else
      flash.now[:error] = @citation.errors.full_messages
      render :new
    end
  end

  def edit
    @citation = Citation.where(recipe_id: params[:recipe_id]).find(params[:id])
    authorize @citation

    render :edit
  end

  def update
    @citation = Citation.where(recipe_id: params[:recipe_id]).find(params[:id])
    authorize @citation

    if @citation.update(citation_params)
      flash.notice = 'Citation updated successfully.'
      redirect_to manage_legacy_recipe_citation_path(@citation)
    else
      flash.now[:error] = @citation.errors.full_messages
      render :new
    end
  end

  def destroy
    @citation = Citation.where(recipe_id: params[:recipe_id]).find(params[:id])
    authorize! @citation

    Citation.destroy(@citation.id)

    redirect_to manage_legacy_recipe_citations_path
  end

  private

  def citation_params
    params.require(:citation).permit(
      :id,
      :content_location,
      :content_type,
      :last_accessed_at,
      :origin,
      :publication_location,
      :publication_title,
      :published_at,
      :publisher,
      :site_link,
      :site_title,
      :version
    )
  end
end
