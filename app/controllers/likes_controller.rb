class LikesController < ApplicationController
  before_action :post_params, only: %i[create destroy]
  def create
    current_user.likes.create(post_id: @post.id)
  end

  private

  def post_params
    @post = Post.find(params[:post_id])
  end
end
