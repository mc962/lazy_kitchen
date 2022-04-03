# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.published.directory(params[:page])

    render :index
  end

  def show
    @post = Post.published.managed.friendly.find(params[:id])

    render :show
  end
end
