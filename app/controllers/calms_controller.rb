class CalmsController < ApplicationController
  before_action :post_params, only: %i[create destroy]
  def create
      calm = current_user.calms.create(post_id: @post.id)
  end

  def destroy
      calm = Calm.find_by(post_id: @post.id, user_id: current_user.id)
      calm.destroy
  end

  private
  
  def post_params
      @post = Post.find(params[:post_id])
  end
end
