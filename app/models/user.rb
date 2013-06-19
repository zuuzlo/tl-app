class User < ActiveRecord::Base
  has_secure_password
  
  has_many  :posts, order: 'created_at desc'
  has_many  :comments
  validates :username, presence: true, length: {minimum: 4}, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 4}
end 