class Manage::Legacy::CitationsController < ApplicationController
  # @todo Authenticate
  def show
    @citation = Citation.find(params[:id])

    render :show
  end

  def new
    @citation = Citation.new(recipe_id: params[:recipe_id])

    render :new
  end

  def create
    @citation = Citation.new(citation_params)

    if @citation.save
      flash.notice = 'Citation created successfully.'
      redirect_to manage_legacy_recipe_citation_path(@citation)
    else
      flash.now.error = @citation.errors.full_messages
      render :new
    end
  end

  def edit
    @citation = Citation.find(params[:id])

    render :edit
  end

  def update
    @citation = Citation.find(params[:id])

    if @citation.update(citation_params)
      flash.notice = 'Citation updated successfully.'
      redirect_to manage_legacy_recipe_citation_path(@citation)
    else
      flash.now.error = @citation.errors.full_messages
      render :new
    end
  end

  def destroy
    begin
      @citation.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("Record not found with id #{params[:id]}, deletion was skipped.")
    end

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
