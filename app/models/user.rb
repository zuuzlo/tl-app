class User < ActiveRecord::Base
  
  has_many :posts
  #has_many :categories, :through => :posts_categories
end 