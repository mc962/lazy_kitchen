class API::StepsController < API::ApplicationController
  def create
    @step = Step.new(step_params)

    if @step.save
      render json: {
        path: recipe_path(params[:recipe_id])
      }, status: :created
    else
      render json: {
        errors: @step.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    @step = Step.includes(:step_ingredients).find(params[:id])
    if @step.update(step_params)
      render json: {
        path: recipe_path(params[:recipe_id])
      }
    else
      render json: {
        errors: @step.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      Step.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("No step to delete with id of #{params[:id]}")
    end

    render json: {
      path: recipe_path(params[:recipe_id])
    }
  end

  private

  def step_params
    params.require(:step).permit(
      :id,
      :instruction,
      :order,
      :recipe_id
    )
  end
end

