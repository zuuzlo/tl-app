class Category < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many   :posts_categories
  has_many   :posts, through: :posts_categories

  validates :name, presence: true
  
end 