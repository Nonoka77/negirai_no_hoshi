class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @posts= Post.where(user_id: current_user.id).order(created_at: :desc)
  end
end
