# frozen_string_literal: true

class API::PostsController < API::ApplicationController
  def index
    @posts = Post.where(user_id: current_user.id)

    authorize!

    render json: @posts.map { |post|
      {
        id: post.id,
        title: post.title,
        _link: api_post_url(post)
      }
    }
  end

  def show
    @post = Post.where(user_id: current_user.id).friendly.find(params[:id])

    authorize! @post

    render json: {
      id: @post.id,
      title: @post.title,
      published: @post.published,
      published_at: @post.published_at,
      modified_at: @post.modified_at,
      content: @post.content
    }
  end
end
