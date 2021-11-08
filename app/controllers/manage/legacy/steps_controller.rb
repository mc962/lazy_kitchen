class Manage::Legacy::StepsController < Manage::Legacy::ApplicationController
  def show
    @step = Step.where(recipe_id: params[:recipe_id]).find(params[:id])
    authorize! @step

    render :show
  end

  def new
    @step = Step.new(recipe_id: params[:recipe_id])
    authorize!

    render :new
  end

  def create
    @step = Step.new(step_params)
    authorize! @step

    if @step.save
      flash.notice = 'Step created successfully.'
      redirect_to manage_legacy_recipe_step_path(@step)
    else
      flash.now[:error] = @step.errors.full_messages
      render :new
    end
  end

  def edit
    @step = Step.where(recipe_id: params[:recipe_id]).find(params[:id])
    authorize! @step

    render :edit
  end

  def update
    @step = Step.where(recipe_id: params[:recipe_id]).find(params[:id])
    authorize! @step

    if @step.update(step_params)
      flash.notice = 'Step updated successfully.'
      redirect_to manage_legacy_recipe_step_path(@step)
    else
      flash.now[:error] = @step.errors.full_messages
      render :new
    end
  end

  def destroy
    @step = Step.where(recipe_id: params[:recipe_id]).find(params[:id])
    authorize! @step

    Step.destroy(@step.id)

    redirect_to manage_legacy_recipe_steps_path
  end

  private

  def step_params
    params.require(:step).permit(
      :id,
      :instruction,
      :order,
    )
  end
end
