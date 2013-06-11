class Category < ActiveRecord::Base
  belongs_to :post
  has_many   :posts_categories
  has_many   :posts, through: :posts_categories
  
end 