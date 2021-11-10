class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: {minimum: 1 }

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

  def self.guest
    find_or_create_by!(email: 'guest@example.com', username: 'guest') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end

  def not_guest?
    self.email != 'guest@example.com' && self.username != 'guest'
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def already_calmed?(post)
    self.calms.exists?(post_id: post.id)
  end

  def already_cheered?(post)
    self.cheers.exists?(post_id: post.id)
  end
end
