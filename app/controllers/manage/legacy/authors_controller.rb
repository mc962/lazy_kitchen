class Manage::Legacy::AuthorsController < Manage::Legacy::ApplicationController
  def show
    @author = Author.managed.where(citation_id: params[:citation_id]).find(params[:id])
    authorize! @author

    render :show
  end

  def new
    @author = Author.new(citation_id: params[:citation_id])
    authorize!

    render :new
  end

  def create
    @author = Author.new(author_params)
    authorize! @author

    if @author.save
      flash.notice = 'Citation Author created successfully.'
      redirect_to manage_legacy_recipe_citation_author_path(@author)
    else
      flash.now[:error] = @author.errors.full_messages
      render :new
    end
  end

  def edit
    @author = Author.managed.where(citation_id: params[:citation_id]).find(params[:id])
    authorize! @author

    render :edit
  end

  def update
    @author = Author.managed.where(citation_id: params[:citation_id]).find(params[:id])
    authorize! @author

    if @author.update(author_params)
      flash.notice = 'Citation Author updated successfully.'
      redirect_to manage_legacy_recipe_citation_author_path(@author)
    else
      flash.now[:error] = @author.errors.full_messages
      render :new
    end
  end

  def destroy
    @author = Author.managed.where(citation_id: params[:citation_id]).find(params[:id])
    authorize! @author

    Author.destroy(@author.id)

    redirect_to manage_legacy_recipe_citation_authors_path
  end

  private

  def author_params
    params.require(:author).permit(
      :id,
      :first_name,
      :middle_name,
      :last_name
    )
  end
end
