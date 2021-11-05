class Manage::Legacy::StepsController < ApplicationController
  # @todo Authenticate
  def show
    @step = Step.find(params[:id])

    render :show
  end

  def new
    @step = Step.new(recipe_id: params[:recipe_id])

    render :new
  end

  def create
    @step = Step.new(step_params)

    if @step.save
      flash.notice = 'Step created successfully.'
      redirect_to manage_legacy_recipe_step_path(@step)
    else
      flash.now.error = @step.errors.full_messages
      render :new
    end
  end

  def edit
    @step = Step.find(params[:id])

    render :edit
  end

  def update
    @step = Step.find(params[:id])

    if @step.update(step_params)
      flash.notice = 'Step updated successfully.'
      redirect_to manage_legacy_recipe_step_path(@step)
    else
      flash.now.error = @step.errors.full_messages
      render :new
    end
  end

  def destroy
    begin
      @step.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("Record not found with id #{params[:id]}, deletion was skipped.")
    end

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
