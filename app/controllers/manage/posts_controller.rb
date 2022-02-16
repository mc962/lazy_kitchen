class Manage::PostsController < Manage::ApplicationController
  include Imageable

  def index
    @posts = Post.owned(current_user.id).directory_posts(params[:page])
    authorize!

    render :index
  end

  def show
    @post = Post.friendly.find(params[:id])
    authorize! @post

    render :show
  end

  def new
    @post = Post.new
    authorize!

    render :new
  end

  def create
    @post = Post.new(post_params)
    # Associate Post created through Public Endpoints with currently authenticated user
    @post.author = current_user
    authorize! @post

    if @post.save
      flash.notice = 'Post created successfully.'
      redirect_to manage_post_path(@post)
    else
      flash.now[:error] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
    authorize! @post

    render :edit
  end

  def update
    @post = Post.friendly.find(params[:id])
    authorize! @post

    if @post.update(post_params)
      flash.notice = 'Post updated successfully.'
      redirect_to manage_post_path(@post)
    else
      flash.now[:error] = @post.errors.full_message
      render :edit
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    authorize! @post

    Post.destroy(@post.id)

    redirect_to manage_posts_path
  end

  private

  def post_params
    params.require(:post).permit(
      :id,
      :title,
      :content,
      :published,
      :published_at,
      :modified_at
    )
  end
end
