class CheersController < ApplicationController
  before_action :post_params, only: %i[create destroy]
  def create
    binding.pry
      cheer = current_user.cheers.create(post_id: @post.id)
  end

  def destroy
      cheer = Cheer.find_by(post_id: @post.id, user_id: current_user.id)
      cheer.destroy
  end

  private
  
  def post_params
      @post = Post.find(params[:post_id])
  end
end
