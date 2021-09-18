class API::AuthorsController < API::ApplicationController
  def create
    @author = Author.new(author_params)

    if @author.save!
      render json: {
        path: recipe_path(params[:recipe_id])
      }, status: :created
    else
      render json: {
        errors: @author.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    @author = Author.find(params[:id])

    if @author.update(author_params)
      render json: {
        path: recipe_path(params[:recipe_id])
      }
    else
      render json: {
        errors: @author.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      Author.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("No Author to delete with id of #{params[:id]}")
    end

    render json: {
      path: recipe_path(params[:recipe_id])
    }
  end

  private

  def author_params
    params.require(:author).permit(
      :id,
      :first_name,
      :middle_name,
      :last_name,
      :citation_id
    )
  end
end