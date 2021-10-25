class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |f|
        f.html { redirect_to posts_path }
        f.json { render json: { content: @post.content, username: @post.user.username, user_id: @post.user_id, id: @post.id} }
      end 
    end
  end

  def index
    @post = Post.new
    @posts = Post.includes(:user)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      respond_to do |f|
        f.html { redirect_to posts_path }
        f.json { render json: { id: params[:id]} }
      end 
    end
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end
end
