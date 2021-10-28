class ProfilesController < ApplicationController
  before_action :set_user, only: %i[update edit]
  def show; end

  def edit; end

  def update
    @user.update!(user_params)
  end

  private

  def set_user
    @user = User.find(id: current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :avatar, :avatar_catche)
  end
end
