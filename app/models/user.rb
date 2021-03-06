class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 1 }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :calms, dependent: :destroy
  has_many :cheers, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
