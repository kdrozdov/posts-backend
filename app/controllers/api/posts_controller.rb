class Api::PostsController < ApplicationController
  # GET /api/posts
  def index
    render json: posts
  end

  # GET /api/posts/1
  def show
    render json: post
  end

  # POST /api/posts
  def create
    @post = Post.new(post_params)

    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/posts/1
  def update
    if post.update(post_params)
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/posts/1
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
    params.require(:post).permit(:title, :body)
  end
end
