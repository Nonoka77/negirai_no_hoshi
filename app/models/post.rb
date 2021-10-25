class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255}

end
