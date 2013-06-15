class Post < ActiveRecord::Base
  
  belongs_to  :user
  has_many    :posts_categories
  has_many    :categories, through: :posts_categories
  has_many    :comments
  # has_many    :postcomments
  # has_many    :comments, through: :postcomments



  validates :title, presence: true
  validates :url, presence: true
end 