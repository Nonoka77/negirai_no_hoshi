class ProfilesController < ApplicationController
  before_action :set_user
  def show; end

  def edit; end

  def update
    @user.update!(user_params)
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :avatar, :avatar_catche)
  end
end
