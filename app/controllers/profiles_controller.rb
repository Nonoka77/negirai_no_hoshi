class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update edit]
  before_action :valid_guest, only: %i[edit]
  def show
    @posts = Post.where(user_id: current_user.id).order(created_at: :desc)
  end

  def edit; end

  def update
    @user.update!(user_params)
    redirect_to profiles_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :avatar, :avatar_catche)
  end

  def valid_guest
    if current_user.email == 'guest@example.com' && current_user.username == 'guest'
      redirect_to root_path, notice: 'ゲストユーザーは編集できません。'
    end
  end
end
