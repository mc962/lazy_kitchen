class Manage::Legacy::AuthorsController < Manage::Legacy::ApplicationController
  def show
    @author = Author.find(params[:id])

    render :show
  end

  def new
    @author = Author.new(citation_id: params[:citation_id])

    render :new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      flash.notice = 'Citation Author created successfully.'
      redirect_to manage_legacy_recipe_citation_author_path(@author)
    else
      flash.now[:error] = @author.errors.full_messages
      render :new
    end
  end

  def edit
    @author = Author.find(params[:id])

    render :edit
  end

  def update
    @author = Author.find(params[:id])

    if @author.update(author_params)
      flash.notice = 'Citation Author updated successfully.'
      redirect_to manage_legacy_recipe_citation_author_path(@author)
    else
      flash.now[:error] = @author.errors.full_messages
      render :new
    end
  end

  def destroy
    begin
      @author.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn("Record not found with id #{params[:id]}, deletion was skipped.")
    end

    redirect_to manage_legacy_recipe_citations_authors_path
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
