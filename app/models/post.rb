class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :calms, dependent: :destroy
  has_many :cheers, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }
end
