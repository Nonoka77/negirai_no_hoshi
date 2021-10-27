class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :calms, dependent: :destroy

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

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
