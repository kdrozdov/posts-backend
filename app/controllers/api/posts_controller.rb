class Api::PostsController < ApplicationController
  before_action :authenticate_user, only: %i(create update destroy)

  def index
    render json: posts
  end

  def show
    render json: post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    if post.update(post_params)
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    post.destroy
    head :no_content
  end

  private

  def post
    @post ||= Post.find(params[:id])
  end

  def posts
    @posts ||= Post.all
  end

  def post_params
    permitted_attributes = %i(
      title
      body
    )
    params.require(:post).permit(permitted_attributes)
  end
end
