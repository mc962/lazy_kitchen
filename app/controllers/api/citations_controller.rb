class API::CitationsController < API::ApplicationController
  def create
    @citation = Citation.new(citation_params)

    if @citation.save!
      render json: {
        path: recipe_path(params[:recipe_id])
      }, status: :created
    else
      render json: {
        errors: @citation.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    @citation = Citation.includes(:authors).find(params[:id])

    if @citation.update(citation_params)
      render json: {
      path: recipe_path(params[:recipe_id])
    }
    else
      render json: {
        errors: @citation.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      Citation.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("No Citation to delete with id of #{params[:id]}")
    end

    render json: {
      path: recipe_path(params[:recipe_id])
    }
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
      :version,
      :recipe_id,
      authors_attributes: [
        :id,
        :first_name,
        :middle_name,
        :last_name
      ]
    )
  end
end
