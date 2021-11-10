class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :authenticate_user!

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |f|
        f.html { redirect_to posts_path }
        f.json do
          render json: { content: @post.content, username: @post.user.username, user_id: @post.user_id, id: @post.id }
        end
      end
    end
  end

  def edit; end

  def update
    @post.update!(post_update_params)
    respond_to do |f|
      f.html { redirect_to posts_path }
      f.json { render json: { content: @post.content, user_id: @post.user_id, id: @post.id } }
    end
  end

  def index
    @post = Post.new
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def destroy
    if @post.destroy
      respond_to do |f|
        f.html { redirect_to posts_path }
        f.json { render json: { id: params[:id] } }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end

  def post_update_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
